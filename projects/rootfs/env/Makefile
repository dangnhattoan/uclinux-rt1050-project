# Makefile for the U-boot env management tools
#
all             : apps
clean           : clean_apps

APPS            = ${INSTALL_ROOT}/u-boot/tools/env/fw_printenv
apps            : $(APPS)
$(APPS)		: 
	(cd ${INSTALL_ROOT}/u-boot/; \
	make distclean; \
	case $$MCU in \
	  IMXRT105X_NXPEVK) cfg="mxrt105x-evk_defconfig";; \
	  IMXRT105X_ZB) cfg="mxrt105x-zb_defconfig";; \
	  STM32F4X9) cfg="stm-som_config";; \
	  STM32F769IDISCO) cfg="stm32f769i-discovery";; \
	  STM32F7) \
		case $$BRD in \
		  EXT-BSB) cfg="stm32f7-som-ext-bsb_config";; \
		  *) cfg="stm32f7-som_config";; \
		esac;; \
	  *) echo "Unknown target, assuming STM-SOM"; cfg="stm-som_config";; \
	esac; \
	make $$cfg; \
	case $$CROSS_COMPILE in \
	  arm-v7-linux-uclibceabi-) \
		make -s env HOST_EXTRALDFLAGS="-static";; \
	  *) \
		make -s env CPPFLAGS="-Wall -DUSE_HOSTCC -I`pwd`/include \
			-mcpu=cortex-m4 -mthumb";; \
	esac;)

clean_apps      :
	-rm -f $(APPS)
