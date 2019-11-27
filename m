Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581A810A813
	for <lists+linux-api@lfdr.de>; Wed, 27 Nov 2019 02:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfK0BpZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Nov 2019 20:45:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34131 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfK0BpZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Nov 2019 20:45:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id h13so9015583plr.1;
        Tue, 26 Nov 2019 17:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gltv/+jH9c4UjF5jAX3xq9ozMHpKN8xQK+R+ga7Yf8I=;
        b=Me8ikztWpins6fp9bjMXNNi9aNvJQDYc1MMwGTKA4bVCYoEJyqbXMrhrcaVvkjpGdZ
         4FZ04OA+66o120wpVqQCj2AN9jPhocddBPA+A0HINNUbCxSve4wC8/ybKdkFUla09iov
         FUh3eRcfyvebAQfYLB3M4kTMOi8Hhx+i+NxyHsx9Cdk1uiaPxxfTZTtSyAXqpHsPVOjH
         QTDE5TLxhD4JrqgiZUc8zNjyyrghY0xiTO4T5ajQ0JPVD518TKpq0iU6Ud/XdDO3y6rS
         OvEATP5La+r8I0U4gm+ukbF8G8/p5igCzMfCgek+kycoM2sPDHGEYqZ2AHpqs2WHkHty
         Vq8Q==
X-Gm-Message-State: APjAAAWs8MutnB2ZQc/4SvkV4cja7nswcNUoNMqyhw50tTfOouq9gZpk
        Qq9fsXk0rn/mYc8SGB9KzCc=
X-Google-Smtp-Source: APXvYqxyL4oLwXQG/PLUyYDH8/bfh+rSKxoeaV+WhAVYvK22FD5bmVkAu6HTPu+j5W9VhObOIvyJxA==
X-Received: by 2002:a17:90a:25a1:: with SMTP id k30mr2907770pje.9.1574819123220;
        Tue, 26 Nov 2019 17:45:23 -0800 (PST)
Received: from localhost ([2601:647:5b00:424:6361:2bd9:c43a:bc72])
        by smtp.gmail.com with ESMTPSA id 21sm14097496pfa.170.2019.11.26.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 17:45:22 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:45:20 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org,
        gregkh@linuxfoundation.org, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v6 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20191127014520.GA168275@archbox>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
 <1573622695-25607-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573622695-25607-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Hao,

On Wed, Nov 13, 2019 at 01:24:55PM +0800, Wu Hao wrote:
> This patch adds support for performance reporting private feature
> for FPGA Management Engine (FME). Now it supports several different
> performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> and 'vtd_sip'. It allows user to use standard linux tools to access
> these performance counters.
> 
> e.g. List all events by "perf list"
> 
>   perf list | grep fme
> 
>   fme0/cache_read_hit/                         [Kernel PMU event]
>   fme0/cache_read_miss/                        [Kernel PMU event]
>   ...
> 
>   fme0/fab_mmio_read/                          [Kernel PMU event]
>   fme0/fab_mmio_write/                         [Kernel PMU event]
>   ...
> 
>   fme0/fab_port_mmio_read,portid=?/            [Kernel PMU event]
>   fme0/fab_port_mmio_write,portid=?/           [Kernel PMU event]
>   ...
> 
>   fme0/vtd_port_devtlb_1g_fill,portid=?/       [Kernel PMU event]
>   fme0/vtd_port_devtlb_2m_fill,portid=?/       [Kernel PMU event]
>   ...
> 
>   fme0/vtd_sip_iotlb_1g_hit/                   [Kernel PMU event]
>   fme0/vtd_sip_iotlb_1g_miss/                  [Kernel PMU event]
>   ...
> 
>   fme0/clock                                   [Kernel PMU event]
>   ...
> 
> e.g. check increased counter value after run one application using
> "perf stat" command.
> 
>  perf stat -e fme0/fab_mmio_read/,fme0/fab_mmio_write/, ./test
> 
>  Performance counter stats for './test':
> 
>                  1      fme0/fab_mmio_read/
>                  2      fme0/fab_mmio_write/
> 
>        1.009496520 seconds time elapsed
> 
> Please note that fabric counters support both fab_* and fab_port_*, but
> actually they are sharing one set of performance counters in hardware.
> If user wants to monitor overall data events on fab_* then fab_port_*
> can't be supported at the same time, see example below:
> 
> perf stat -e fme0/fab_mmio_read/,fme0/fab_port_mmio_write,portid=0/
> 
>  Performance counter stats for 'system wide':
> 
>                  0      fme0/fab_mmio_read/
>    <not supported>      fme0/fab_port_mmio_write,portid=0/
> 
>        2.141064085 seconds time elapsed
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
> v3: replace scnprintf with sprintf in sysfs interfaces.
>     update sysfs doc kernel version and date.
>     fix sysfs doc issue for fabric counter.
>     refine PERF_OBJ_ATTR_* macro, doesn't count on __ATTR anymore.
>     introduce PERF_OBJ_ATTR_F_* macro, as it needs to use different
>     filenames for some of the sysfs attributes.
>     remove kobject_del when destroy kobject, kobject_put is enough.
>     do sysfs_remove_groups first when destroying perf_obj.
>     WARN_ON_ONCE in case internal parms are wrong in read_*_count().
> v4: rework this patch to use standard perf API as user interfaces.
> v5: rebase and clean up.
> v6: use dev_ext_attribute instead of creating new fme_perf_attribute
>     use is_visible function to decide which events to expose per
>     hardware capability, and add event_init checking for all events.
> ---
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-fme-main.c |   4 +
>  drivers/fpga/dfl-fme-perf.c | 943 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl-fme.h      |   2 +
>  drivers/fpga/dfl.h          |   2 +
>  5 files changed, 952 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-perf.c
> 
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 4865b74..d8e21df 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
>  obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
>  
>  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o
> +dfl-fme-objs += dfl-fme-perf.o
>  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs += dfl-afu-error.o
>  
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 7c930e6..53a1447 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -580,6 +580,10 @@ static int fme_power_mgmt_init(struct platform_device *pdev,
>  		.ops = &fme_power_mgmt_ops,
>  	},
>  	{
> +		.id_table = fme_perf_id_table,
> +		.ops = &fme_perf_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	},
>  };
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> new file mode 100644
> index 0000000..5e51727
> --- /dev/null
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -0,0 +1,943 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Management Engine (FME) Global Performance Reporting
> + *
> + * Copyright 2019 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Kang Luwei <luwei.kang@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xu Yilun <yilun.xu@intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Mitchel, Henry <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/perf_event.h>
> +#include "dfl.h"
> +#include "dfl-fme.h"
> +
> +/*
> + * Performance Counter Registers for Cache.
> + *
> + * Cache Events are listed below as CACHE_EVNT_*.
> + */
> +#define CACHE_CTRL			0x8
> +#define CACHE_RESET_CNTR		BIT_ULL(0)
> +#define CACHE_FREEZE_CNTR		BIT_ULL(8)
> +#define CACHE_CTRL_EVNT			GENMASK_ULL(19, 16)
> +#define CACHE_EVNT_RD_HIT		0x0
> +#define CACHE_EVNT_WR_HIT		0x1
> +#define CACHE_EVNT_RD_MISS		0x2
> +#define CACHE_EVNT_WR_MISS		0x3
> +#define CACHE_EVNT_RSVD			0x4
> +#define CACHE_EVNT_HOLD_REQ		0x5
> +#define CACHE_EVNT_DATA_WR_PORT_CONTEN	0x6
> +#define CACHE_EVNT_TAG_WR_PORT_CONTEN	0x7
> +#define CACHE_EVNT_TX_REQ_STALL		0x8
> +#define CACHE_EVNT_RX_REQ_STALL		0x9
> +#define CACHE_EVNT_EVICTIONS		0xa
> +#define CACHE_EVNT_MAX			CACHE_EVNT_EVICTIONS
> +#define CACHE_CHANNEL_SEL		BIT_ULL(20)
> +#define CACHE_CHANNEL_RD		0
> +#define CACHE_CHANNEL_WR		1
> +#define CACHE_CNTR0			0x10
> +#define CACHE_CNTR1			0x18
> +#define CACHE_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> +#define CACHE_CNTR_EVNT			GENMASK_ULL(63, 60)
> +
> +/*
> + * Performance Counter Registers for Fabric.
> + *
> + * Fabric Events are listed below as FAB_EVNT_*
> + */
> +#define FAB_CTRL			0x20
> +#define FAB_RESET_CNTR			BIT_ULL(0)
> +#define FAB_FREEZE_CNTR			BIT_ULL(8)
> +#define FAB_CTRL_EVNT			GENMASK_ULL(19, 16)
> +#define FAB_EVNT_PCIE0_RD		0x0
> +#define FAB_EVNT_PCIE0_WR		0x1
> +#define FAB_EVNT_PCIE1_RD		0x2
> +#define FAB_EVNT_PCIE1_WR		0x3
> +#define FAB_EVNT_UPI_RD			0x4
> +#define FAB_EVNT_UPI_WR			0x5
> +#define FAB_EVNT_MMIO_RD		0x6
> +#define FAB_EVNT_MMIO_WR		0x7
> +#define FAB_EVNT_MAX			FAB_EVNT_MMIO_WR
> +#define FAB_PORT_ID			GENMASK_ULL(21, 20)
> +#define FAB_PORT_FILTER			BIT_ULL(23)
> +#define FAB_PORT_FILTER_DISABLE		0
> +#define FAB_PORT_FILTER_ENABLE		1
> +#define FAB_CNTR			0x28
> +#define FAB_CNTR_EVNT_CNTR		GENMASK_ULL(59, 0)
> +#define FAB_CNTR_EVNT			GENMASK_ULL(63, 60)
> +
> +/*
> + * Performance Counter Registers for Clock.
> + *
> + * Clock Counter can't be reset or frozen by SW.
> + */
> +#define CLK_CNTR			0x30
> +#define BASIC_EVNT_CLK			0x0
> +#define BASIC_EVNT_MAX			BASIC_EVNT_CLK
> +
> +/*
> + * Performance Counter Registers for IOMMU / VT-D.
> + *
> + * VT-D Events are listed below as VTD_EVNT_* and VTD_SIP_EVNT_*
> + */
> +#define VTD_CTRL			0x38
> +#define VTD_RESET_CNTR			BIT_ULL(0)
> +#define VTD_FREEZE_CNTR			BIT_ULL(8)
> +#define VTD_CTRL_EVNT			GENMASK_ULL(19, 16)
> +#define VTD_EVNT_AFU_MEM_RD_TRANS	0x0
> +#define VTD_EVNT_AFU_MEM_WR_TRANS	0x1
> +#define VTD_EVNT_AFU_DEVTLB_RD_HIT	0x2
> +#define VTD_EVNT_AFU_DEVTLB_WR_HIT	0x3
> +#define VTD_EVNT_DEVTLB_4K_FILL		0x4
> +#define VTD_EVNT_DEVTLB_2M_FILL		0x5
> +#define VTD_EVNT_DEVTLB_1G_FILL		0x6
> +#define VTD_EVNT_MAX			VTD_EVNT_DEVTLB_1G_FILL
> +#define VTD_CNTR			0x40
> +#define VTD_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> +#define VTD_CNTR_EVNT			GENMASK_ULL(63, 60)
> +
> +#define VTD_SIP_CTRL			0x48
> +#define VTD_SIP_RESET_CNTR		BIT_ULL(0)
> +#define VTD_SIP_FREEZE_CNTR		BIT_ULL(8)
> +#define VTD_SIP_CTRL_EVNT		GENMASK_ULL(19, 16)
> +#define VTD_SIP_EVNT_IOTLB_4K_HIT	0x0
> +#define VTD_SIP_EVNT_IOTLB_2M_HIT	0x1
> +#define VTD_SIP_EVNT_IOTLB_1G_HIT	0x2
> +#define VTD_SIP_EVNT_SLPWC_L3_HIT	0x3
> +#define VTD_SIP_EVNT_SLPWC_L4_HIT	0x4
> +#define VTD_SIP_EVNT_RCC_HIT		0x5
> +#define VTD_SIP_EVNT_IOTLB_4K_MISS	0x6
> +#define VTD_SIP_EVNT_IOTLB_2M_MISS	0x7
> +#define VTD_SIP_EVNT_IOTLB_1G_MISS	0x8
> +#define VTD_SIP_EVNT_SLPWC_L3_MISS	0x9
> +#define VTD_SIP_EVNT_SLPWC_L4_MISS	0xa
> +#define VTD_SIP_EVNT_RCC_MISS		0xb
> +#define VTD_SIP_EVNT_MAX		VTD_SIP_EVNT_SLPWC_L4_MISS
> +#define VTD_SIP_CNTR			0X50
> +#define VTD_SIP_CNTR_EVNT_CNTR		GENMASK_ULL(47, 0)
> +#define VTD_SIP_CNTR_EVNT		GENMASK_ULL(63, 60)
> +
> +#define PERF_TIMEOUT			30
> +
> +#define PERF_MAX_PORT_NUM		1U
> +
> +/**
> + * struct fme_perf_priv - priv data structure for fme perf driver
> + *
> + * @dev: parent device.
> + * @ioaddr: mapped base address of mmio region.
> + * @pmu: pmu data structure for fme perf counters.
> + * @id: id of this fme performance report private feature.
> + * @fab_users: current user number on fabric counters.
> + * @fab_port_id: used to indicate current working mode of fabric counters.
> + * @fab_lock: lock to protect fabric counters working mode.
> + */
> +struct fme_perf_priv {
> +	struct device *dev;
> +	void __iomem *ioaddr;
> +	struct pmu pmu;
> +	u64 id;
> +
> +	u32 fab_users;
> +	u32 fab_port_id;
> +	spinlock_t fab_lock;
> +};
> +
> +/**
> + * struct fme_perf_event_ops - callbacks for fme perf events
> + *
> + * @event_init: callback invoked during event init.
> + * @event_destroy: callback invoked during event destroy.
> + * @read_counter: callback to read hardware counters.
> + */
> +struct fme_perf_event_ops {
> +	int (*event_init)(struct fme_perf_priv *priv, u32 event, u32 portid);
> +	void (*event_destroy)(struct fme_perf_priv *priv, u32 event,
> +			      u32 portid);
> +	u64 (*read_counter)(struct fme_perf_priv *priv, u32 event, u32 portid);
> +};
> +
> +#define to_fme_perf_priv(_pmu)	container_of(_pmu, struct fme_perf_priv, pmu)
> +
> +static cpumask_t fme_perf_cpumask = CPU_MASK_CPU0;
> +
> +static ssize_t cpumask_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	return cpumap_print_to_pagebuf(true, buf, &fme_perf_cpumask);
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *fme_perf_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group fme_perf_cpumask_group = {
> +	.attrs = fme_perf_cpumask_attrs,
> +};
> +
> +#define FME_EVENT_MASK		GENMASK_ULL(11, 0)
> +#define FME_EVENT_SHIFT		0
> +#define FME_EVTYPE_MASK		GENMASK_ULL(15, 12)
> +#define FME_EVTYPE_SHIFT	12
> +#define FME_EVTYPE_BASIC	0
> +#define FME_EVTYPE_CACHE	1
> +#define FME_EVTYPE_FABRIC	2
> +#define FME_EVTYPE_VTD		3
> +#define FME_EVTYPE_VTD_SIP	4
> +#define FME_EVTYPE_MAX		FME_EVTYPE_VTD_SIP
> +#define FME_PORTID_MASK		GENMASK_ULL(23, 16)
> +#define FME_PORTID_SHIFT	16
> +#define FME_PORTID_ROOT		(0xffU)
> +
> +#define get_event(_config)	FIELD_GET(FME_EVENT_MASK, _config)
> +#define get_evtype(_config)	FIELD_GET(FME_EVTYPE_MASK, _config)
> +#define get_portid(_config)	FIELD_GET(FME_PORTID_MASK, _config)
> +
> +PMU_FORMAT_ATTR(event,		"config:0-11");
> +PMU_FORMAT_ATTR(evtype,		"config:12-15");
> +PMU_FORMAT_ATTR(portid,		"config:16-23");
> +
> +static struct attribute *fme_perf_format_attrs[] = {
> +	&format_attr_event.attr,
> +	&format_attr_evtype.attr,
> +	&format_attr_portid.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group fme_perf_format_group = {
> +	.name = "format",
> +	.attrs = fme_perf_format_attrs,
> +};
> +
> +static struct attribute *fme_perf_events_attrs_empty[] = {
> +	NULL,
> +};
> +
> +static struct attribute_group fme_perf_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_events_attrs_empty,
> +};
> +
> +static const struct attribute_group *fme_perf_groups[] = {
> +	&fme_perf_format_group,
> +	&fme_perf_cpumask_group,
> +	&fme_perf_events_group,
> +	NULL,
> +};
> +
> +static bool is_portid_root(u32 portid)
> +{
> +	return portid == FME_PORTID_ROOT;
> +}
> +
> +static bool is_portid_port(u32 portid)
> +{
> +	return portid < PERF_MAX_PORT_NUM;
> +}
> +
> +static bool is_portid_root_or_port(u32 portid)
> +{
> +	return is_portid_root(portid) || is_portid_port(portid);
> +}
> +
> +static int basic_event_init(struct fme_perf_priv *priv, u32 event, u32 portid)
> +{
> +	if (event <= BASIC_EVNT_MAX && is_portid_root(portid))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static u64 basic_read_event_counter(struct fme_perf_priv *priv,
> +				    u32 event, u32 portid)
> +{
> +	void __iomem *base = priv->ioaddr;
> +
> +	return readq(base + CLK_CNTR);
> +}
> +
> +static int cache_event_init(struct fme_perf_priv *priv, u32 event, u32 portid)
> +{
> +	if (priv->id == FME_FEATURE_ID_GLOBAL_IPERF &&
> +	    event <= CACHE_EVNT_MAX && is_portid_root(portid))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static u64 cache_read_event_counter(struct fme_perf_priv *priv,
> +				    u32 event, u32 portid)
> +{
> +	void __iomem *base = priv->ioaddr;
> +	u64 v, count;
> +	u8 channel;
> +
> +	if (event == CACHE_EVNT_WR_HIT || event == CACHE_EVNT_WR_MISS ||
> +	    event == CACHE_EVNT_DATA_WR_PORT_CONTEN ||
> +	    event == CACHE_EVNT_TAG_WR_PORT_CONTEN)
> +		channel = CACHE_CHANNEL_WR;
> +	else
> +		channel = CACHE_CHANNEL_RD;
> +
> +	/* set channel access type and cache event code. */
> +	v = readq(base + CACHE_CTRL);
> +	v &= ~(CACHE_CHANNEL_SEL | CACHE_CTRL_EVNT);
> +	v |= FIELD_PREP(CACHE_CHANNEL_SEL, channel);
> +	v |= FIELD_PREP(CACHE_CTRL_EVNT, event);
> +	writeq(v, base + CACHE_CTRL);
> +
> +	if (readq_poll_timeout_atomic(base + CACHE_CNTR0, v,
> +				      FIELD_GET(CACHE_CNTR_EVNT, v) == event,
> +				      1, PERF_TIMEOUT)) {
> +		dev_err(priv->dev, "timeout, unmatched cache event code in counter register.\n");
> +		return 0;
> +	}
> +
> +	v = readq(base + CACHE_CNTR0);
> +	count = FIELD_GET(CACHE_CNTR_EVNT_CNTR, v);
> +	v = readq(base + CACHE_CNTR1);
> +	count += FIELD_GET(CACHE_CNTR_EVNT_CNTR, v);
> +
> +	return count;
> +}
> +
> +static bool is_fabric_event_supported(struct fme_perf_priv *priv, u32 event,
> +				      u32 portid)
> +{
> +	if (event > FAB_EVNT_MAX || !is_portid_root_or_port(portid))
> +		return false;
> +
> +	if (priv->id == FME_FEATURE_ID_GLOBAL_DPERF &&
> +	    (event == FAB_EVNT_PCIE1_RD || event == FAB_EVNT_UPI_RD ||
> +	     event == FAB_EVNT_PCIE1_WR || event == FAB_EVNT_UPI_WR))
> +		return false;
> +
> +	return true;
> +}
> +
> +static int fabric_event_init(struct fme_perf_priv *priv, u32 event, u32 portid)
> +{
> +	void __iomem *base = priv->ioaddr;
> +	int ret = 0;
> +	u64 v;
> +
> +	if (!is_fabric_event_supported(priv, event, portid))
> +		return -EINVAL;
> +
> +	/*
> +	 * as fabric counter set only can be in either overall or port mode.
> +	 * In overall mode, it counts overall data for FPGA, and in port mode,
> +	 * it is configured to monitor on one individual port.
> +	 *
> +	 * so every time, a new event is initialized, driver checks
> +	 * current working mode and if someone is using this counter set.
> +	 */
> +	spin_lock(&priv->fab_lock);
> +	if (priv->fab_users && priv->fab_port_id != portid) {
> +		dev_dbg(priv->dev, "conflict fabric event monitoring mode.\n");
> +		ret = -EOPNOTSUPP;
> +		goto exit;
> +	}
> +
> +	priv->fab_users++;
> +
> +	/*
> +	 * skip if current working mode matches, otherwise change the working
> +	 * mode per input port_id, to monitor overall data or another port.
> +	 */
> +	if (priv->fab_port_id == portid)
> +		goto exit;
> +
> +	priv->fab_port_id = portid;
> +
> +	v = readq(base + FAB_CTRL);
> +	v &= ~(FAB_PORT_FILTER | FAB_PORT_ID);
> +
> +	if (is_portid_root(portid)) {
> +		v |= FIELD_PREP(FAB_PORT_FILTER, FAB_PORT_FILTER_DISABLE);
> +	} else {
> +		v |= FIELD_PREP(FAB_PORT_FILTER, FAB_PORT_FILTER_ENABLE);
> +		v |= FIELD_PREP(FAB_PORT_ID, portid);
> +	}
> +	writeq(v, base + FAB_CTRL);
> +
> +exit:
> +	spin_unlock(&priv->fab_lock);
> +	return ret;
> +}
> +
> +static void fabric_event_destroy(struct fme_perf_priv *priv, u32 event,
> +				 u32 portid)
> +{
> +	spin_lock(&priv->fab_lock);
> +	priv->fab_users--;
> +	spin_unlock(&priv->fab_lock);
> +}
> +
> +static u64 fabric_read_event_counter(struct fme_perf_priv *priv, u32 event,
> +				     u32 portid)
> +{
> +	void __iomem *base = priv->ioaddr;
> +	u64 v;
> +
> +	v = readq(base + FAB_CTRL);
> +	v &= ~FAB_CTRL_EVNT;
> +	v |= FIELD_PREP(FAB_CTRL_EVNT, event);
> +	writeq(v, base + FAB_CTRL);
> +
> +	if (readq_poll_timeout_atomic(base + FAB_CNTR, v,
> +				      FIELD_GET(FAB_CNTR_EVNT, v) == event,
> +				      1, PERF_TIMEOUT)) {
> +		dev_err(priv->dev, "timeout, unmatched fab event code in counter register.\n");
> +		return 0;
> +	}
> +
> +	v = readq(base + FAB_CNTR);
> +	return FIELD_GET(FAB_CNTR_EVNT_CNTR, v);
> +}
> +
> +static int vtd_event_init(struct fme_perf_priv *priv, u32 event, u32 portid)
> +{
> +	if (priv->id == FME_FEATURE_ID_GLOBAL_IPERF &&
> +	    event <= VTD_EVNT_MAX && is_portid_port(portid))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static u64 vtd_read_event_counter(struct fme_perf_priv *priv, u32 event,
> +				  u32 portid)
> +{
> +	void __iomem *base = priv->ioaddr;
> +	u64 v;
> +
> +	event += (portid * (VTD_EVNT_MAX + 1));
> +
> +	v = readq(base + VTD_CTRL);
> +	v &= ~VTD_CTRL_EVNT;
> +	v |= FIELD_PREP(VTD_CTRL_EVNT, event);
> +	writeq(v, base + VTD_CTRL);
> +
> +	if (readq_poll_timeout_atomic(base + VTD_CNTR, v,
> +				      FIELD_GET(VTD_CNTR_EVNT, v) == event,
> +				      1, PERF_TIMEOUT)) {
> +		dev_err(priv->dev, "timeout, unmatched vtd event code in counter register.\n");
> +		return 0;
> +	}
> +
> +	v = readq(base + VTD_CNTR);
> +	return FIELD_GET(VTD_CNTR_EVNT_CNTR, v);
> +}
> +
> +static int vtd_sip_event_init(struct fme_perf_priv *priv, u32 event, u32 portid)
> +{
> +	if (priv->id == FME_FEATURE_ID_GLOBAL_IPERF &&
> +	    event <= VTD_SIP_EVNT_MAX && is_portid_root(portid))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static u64 vtd_sip_read_event_counter(struct fme_perf_priv *priv, u32 event,
> +				      u32 portid)
> +{
> +	void __iomem *base = priv->ioaddr;
> +	u64 v;
> +
> +	v = readq(base + VTD_SIP_CTRL);
> +	v &= ~VTD_SIP_CTRL_EVNT;
> +	v |= FIELD_PREP(VTD_SIP_CTRL_EVNT, event);
> +	writeq(v, base + VTD_SIP_CTRL);
> +
> +	if (readq_poll_timeout_atomic(base + VTD_SIP_CNTR, v,
> +				      FIELD_GET(VTD_SIP_CNTR_EVNT, v) == event,
> +				      1, PERF_TIMEOUT)) {
> +		dev_err(priv->dev, "timeout, unmatched vtd sip event code in counter register\n");
> +		return 0;
> +	}
> +
> +	v = readq(base + VTD_SIP_CNTR);
> +	return FIELD_GET(VTD_SIP_CNTR_EVNT_CNTR, v);
> +}
> +
> +static struct fme_perf_event_ops fme_perf_event_ops[] = {
> +	[FME_EVTYPE_BASIC]	= {.event_init = basic_event_init,
> +				   .read_counter = basic_read_event_counter,},
> +	[FME_EVTYPE_CACHE]	= {.event_init = cache_event_init,
> +				   .read_counter = cache_read_event_counter,},
> +	[FME_EVTYPE_FABRIC]	= {.event_init = fabric_event_init,
> +				   .event_destroy = fabric_event_destroy,
> +				   .read_counter = fabric_read_event_counter,},
> +	[FME_EVTYPE_VTD]	= {.event_init = vtd_event_init,
> +				   .read_counter = vtd_read_event_counter,},
> +	[FME_EVTYPE_VTD_SIP]	= {.event_init = vtd_sip_event_init,
> +				   .read_counter = vtd_sip_read_event_counter,},
> +};
> +
> +static ssize_t fme_perf_event_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +	unsigned long config;
> +	char *ptr = buf;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	config = (unsigned long)eattr->var;
> +
> +	ptr += sprintf(ptr, "event=0x%02x", (unsigned int)get_event(config));
> +	ptr += sprintf(ptr, ",evtype=0x%02x", (unsigned int)get_evtype(config));
> +
> +	if (is_portid_root(get_portid(config)))
> +		ptr += sprintf(ptr, ",portid=0x%02x\n", FME_PORTID_ROOT);
> +	else
> +		ptr += sprintf(ptr, ",portid=?\n");
> +
> +	return (ssize_t)(ptr - buf);
> +}
> +
> +#define FME_EVENT_ATTR(_name) \
> +	__ATTR(_name, 0444, fme_perf_event_show, NULL)
> +
> +#define FME_PORT_EVENT_CONFIG(_event, _type)				\
> +	(void *)((((_event) << FME_EVENT_SHIFT) & FME_EVENT_MASK) |	\
> +		(((_type) << FME_EVTYPE_SHIFT) & FME_EVTYPE_MASK))
> +
> +#define FME_EVENT_CONFIG(_event, _type)					\
> +	(void *)((((_event) << FME_EVENT_SHIFT) & FME_EVENT_MASK) |	\
> +		(((_type) << FME_EVTYPE_SHIFT) & FME_EVTYPE_MASK) |	\
> +		(FME_PORTID_ROOT << FME_PORTID_SHIFT))
> +
> +/* FME Perf Basic Events */
> +#define FME_EVENT_BASIC(_name, _event)					\
> +static struct dev_ext_attribute fme_perf_event_##_name = {		\
> +	.attr = FME_EVENT_ATTR(_name),					\
> +	.var = FME_EVENT_CONFIG(_event, FME_EVTYPE_BASIC),		\
> +}
> +
> +FME_EVENT_BASIC(clock, BASIC_EVNT_CLK);
> +
> +static struct attribute *fme_perf_basic_events_attrs[] = {
> +	&fme_perf_event_clock.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group fme_perf_basic_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_basic_events_attrs,
> +};
> +
> +/* FME Perf Fabric Events */
> +#define FME_EVENT_FABRIC(_name, _event)					\
> +static struct dev_ext_attribute fme_perf_event_fab_##_name = {		\
> +	.attr = FME_EVENT_ATTR(fab_##_name),				\
> +	.var = FME_EVENT_CONFIG(_event, FME_EVTYPE_FABRIC),		\
> +}
> +
> +#define FME_EVENT_FABRIC_PORT(_name, _event)				\
> +static struct dev_ext_attribute fme_perf_event_fab_port_##_name = {	\
> +	.attr = FME_EVENT_ATTR(fab_port_##_name),			\
> +	.var = FME_PORT_EVENT_CONFIG(_event, FME_EVTYPE_FABRIC),	\
> +}
> +
> +FME_EVENT_FABRIC(pcie0_read,  FAB_EVNT_PCIE0_RD);
> +FME_EVENT_FABRIC(pcie0_write, FAB_EVNT_PCIE0_WR);
> +FME_EVENT_FABRIC(pcie1_read,  FAB_EVNT_PCIE1_RD);
> +FME_EVENT_FABRIC(pcie1_write, FAB_EVNT_PCIE1_WR);
> +FME_EVENT_FABRIC(upi_read,    FAB_EVNT_UPI_RD);
> +FME_EVENT_FABRIC(upi_write,   FAB_EVNT_UPI_WR);
> +FME_EVENT_FABRIC(mmio_read,   FAB_EVNT_MMIO_RD);
> +FME_EVENT_FABRIC(mmio_write,  FAB_EVNT_MMIO_WR);
> +
> +FME_EVENT_FABRIC_PORT(pcie0_read,  FAB_EVNT_PCIE0_RD);
> +FME_EVENT_FABRIC_PORT(pcie0_write, FAB_EVNT_PCIE0_WR);
> +FME_EVENT_FABRIC_PORT(pcie1_read,  FAB_EVNT_PCIE1_RD);
> +FME_EVENT_FABRIC_PORT(pcie1_write, FAB_EVNT_PCIE1_WR);
> +FME_EVENT_FABRIC_PORT(upi_read,    FAB_EVNT_UPI_RD);
> +FME_EVENT_FABRIC_PORT(upi_write,   FAB_EVNT_UPI_WR);
> +FME_EVENT_FABRIC_PORT(mmio_read,   FAB_EVNT_MMIO_RD);
> +FME_EVENT_FABRIC_PORT(mmio_write,  FAB_EVNT_MMIO_WR);
> +
> +static struct attribute *fme_perf_fabric_events_attrs[] = {
> +	&fme_perf_event_fab_pcie0_read.attr.attr,
> +	&fme_perf_event_fab_pcie0_write.attr.attr,
> +	&fme_perf_event_fab_pcie1_read.attr.attr,
> +	&fme_perf_event_fab_pcie1_write.attr.attr,
> +	&fme_perf_event_fab_upi_read.attr.attr,
> +	&fme_perf_event_fab_upi_write.attr.attr,
> +	&fme_perf_event_fab_mmio_read.attr.attr,
> +	&fme_perf_event_fab_mmio_write.attr.attr,
> +	&fme_perf_event_fab_port_pcie0_read.attr.attr,
> +	&fme_perf_event_fab_port_pcie0_write.attr.attr,
> +	&fme_perf_event_fab_port_pcie1_read.attr.attr,
> +	&fme_perf_event_fab_port_pcie1_write.attr.attr,
> +	&fme_perf_event_fab_port_upi_read.attr.attr,
> +	&fme_perf_event_fab_port_upi_write.attr.attr,
> +	&fme_perf_event_fab_port_mmio_read.attr.attr,
> +	&fme_perf_event_fab_port_mmio_write.attr.attr,
> +	NULL,
> +};
> +
> +static umode_t fme_perf_fabric_events_visible(struct kobject *kobj,
> +					      struct attribute *attr, int n)
> +{
> +	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct fme_perf_priv *priv = to_fme_perf_priv(pmu);
> +	struct dev_ext_attribute *eattr;
> +	u64 var;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr.attr);
> +	var = (u64)eattr->var;
> +
> +	if (is_fabric_event_supported(priv, get_event(var), get_portid(var)))
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group fme_perf_fabric_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_fabric_events_attrs,
> +	.is_visible = fme_perf_fabric_events_visible,
> +};
> +
> +/* FME Perf Cache Events */
> +#define FME_EVENT_CACHE(_name, _event)					\
> +static struct dev_ext_attribute fme_perf_event_cache_##_name = {	\
> +	.attr = FME_EVENT_ATTR(cache_##_name),				\
> +	.var = FME_EVENT_CONFIG(_event, FME_EVTYPE_CACHE),		\
> +}
> +
> +FME_EVENT_CACHE(read_hit,     CACHE_EVNT_RD_HIT);
> +FME_EVENT_CACHE(read_miss,    CACHE_EVNT_RD_MISS);
> +FME_EVENT_CACHE(write_hit,    CACHE_EVNT_WR_HIT);
> +FME_EVENT_CACHE(write_miss,   CACHE_EVNT_WR_MISS);
> +FME_EVENT_CACHE(hold_request, CACHE_EVNT_HOLD_REQ);
> +FME_EVENT_CACHE(tx_req_stall, CACHE_EVNT_TX_REQ_STALL);
> +FME_EVENT_CACHE(rx_req_stall, CACHE_EVNT_RX_REQ_STALL);
> +FME_EVENT_CACHE(eviction,     CACHE_EVNT_EVICTIONS);
> +FME_EVENT_CACHE(data_write_port_contention, CACHE_EVNT_DATA_WR_PORT_CONTEN);
> +FME_EVENT_CACHE(tag_write_port_contention,  CACHE_EVNT_TAG_WR_PORT_CONTEN);
> +
> +static struct attribute *fme_perf_cache_events_attrs[] = {
> +	&fme_perf_event_cache_read_hit.attr.attr,
> +	&fme_perf_event_cache_read_miss.attr.attr,
> +	&fme_perf_event_cache_write_hit.attr.attr,
> +	&fme_perf_event_cache_write_miss.attr.attr,
> +	&fme_perf_event_cache_hold_request.attr.attr,
> +	&fme_perf_event_cache_tx_req_stall.attr.attr,
> +	&fme_perf_event_cache_rx_req_stall.attr.attr,
> +	&fme_perf_event_cache_eviction.attr.attr,
> +	&fme_perf_event_cache_data_write_port_contention.attr.attr,
> +	&fme_perf_event_cache_tag_write_port_contention.attr.attr,
> +	NULL,
> +};
> +
> +static umode_t fme_perf_events_visible(struct kobject *kobj,
> +				       struct attribute *attr, int n)
> +{
> +	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +	struct fme_perf_priv *priv = to_fme_perf_priv(pmu);
> +
> +	return (priv->id == FME_FEATURE_ID_GLOBAL_IPERF) ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group fme_perf_cache_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_cache_events_attrs,
> +	.is_visible = fme_perf_events_visible,
> +};
> +
> +/* FME Perf VTD Events */
> +#define FME_EVENT_VTD_PORT(_name, _event)				\
> +static struct dev_ext_attribute fme_perf_event_vtd_port_##_name = {	\
> +	.attr = FME_EVENT_ATTR(vtd_port_##_name),			\
> +	.var = FME_PORT_EVENT_CONFIG(_event, FME_EVTYPE_VTD),		\
> +}
> +
> +FME_EVENT_VTD_PORT(read_transaction,  VTD_EVNT_AFU_MEM_RD_TRANS);
> +FME_EVENT_VTD_PORT(write_transaction, VTD_EVNT_AFU_MEM_WR_TRANS);
> +FME_EVENT_VTD_PORT(devtlb_read_hit,   VTD_EVNT_AFU_DEVTLB_RD_HIT);
> +FME_EVENT_VTD_PORT(devtlb_write_hit,  VTD_EVNT_AFU_DEVTLB_WR_HIT);
> +FME_EVENT_VTD_PORT(devtlb_4k_fill,    VTD_EVNT_DEVTLB_4K_FILL);
> +FME_EVENT_VTD_PORT(devtlb_2m_fill,    VTD_EVNT_DEVTLB_2M_FILL);
> +FME_EVENT_VTD_PORT(devtlb_1g_fill,    VTD_EVNT_DEVTLB_1G_FILL);
> +
> +static struct attribute *fme_perf_vtd_events_attrs[] = {
> +	&fme_perf_event_vtd_port_read_transaction.attr.attr,
> +	&fme_perf_event_vtd_port_write_transaction.attr.attr,
> +	&fme_perf_event_vtd_port_devtlb_read_hit.attr.attr,
> +	&fme_perf_event_vtd_port_devtlb_write_hit.attr.attr,
> +	&fme_perf_event_vtd_port_devtlb_4k_fill.attr.attr,
> +	&fme_perf_event_vtd_port_devtlb_2m_fill.attr.attr,
> +	&fme_perf_event_vtd_port_devtlb_1g_fill.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group fme_perf_vtd_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_vtd_events_attrs,
> +	.is_visible = fme_perf_events_visible,
> +};
> +
> +/* FME Perf VTD SIP Events */
> +#define FME_EVENT_VTD_SIP(_name, _event)				\
> +static struct dev_ext_attribute fme_perf_event_vtd_sip_##_name = {	\
> +	.attr = FME_EVENT_ATTR(vtd_sip_##_name),			\
> +	.var = FME_EVENT_CONFIG(_event, FME_EVTYPE_VTD_SIP),		\
> +}
> +
> +FME_EVENT_VTD_SIP(iotlb_4k_hit,  VTD_SIP_EVNT_IOTLB_4K_HIT);
> +FME_EVENT_VTD_SIP(iotlb_2m_hit,  VTD_SIP_EVNT_IOTLB_2M_HIT);
> +FME_EVENT_VTD_SIP(iotlb_1g_hit,  VTD_SIP_EVNT_IOTLB_1G_HIT);
> +FME_EVENT_VTD_SIP(slpwc_l3_hit,  VTD_SIP_EVNT_SLPWC_L3_HIT);
> +FME_EVENT_VTD_SIP(slpwc_l4_hit,  VTD_SIP_EVNT_SLPWC_L4_HIT);
> +FME_EVENT_VTD_SIP(rcc_hit,       VTD_SIP_EVNT_RCC_HIT);
> +FME_EVENT_VTD_SIP(iotlb_4k_miss, VTD_SIP_EVNT_IOTLB_4K_MISS);
> +FME_EVENT_VTD_SIP(iotlb_2m_miss, VTD_SIP_EVNT_IOTLB_2M_MISS);
> +FME_EVENT_VTD_SIP(iotlb_1g_miss, VTD_SIP_EVNT_IOTLB_1G_MISS);
> +FME_EVENT_VTD_SIP(slpwc_l3_miss, VTD_SIP_EVNT_SLPWC_L3_MISS);
> +FME_EVENT_VTD_SIP(slpwc_l4_miss, VTD_SIP_EVNT_SLPWC_L4_MISS);
> +FME_EVENT_VTD_SIP(rcc_miss,      VTD_SIP_EVNT_RCC_MISS);
> +
> +static struct attribute *fme_perf_vtd_sip_events_attrs[] = {
> +	&fme_perf_event_vtd_sip_iotlb_4k_hit.attr.attr,
> +	&fme_perf_event_vtd_sip_iotlb_2m_hit.attr.attr,
> +	&fme_perf_event_vtd_sip_iotlb_1g_hit.attr.attr,
> +	&fme_perf_event_vtd_sip_slpwc_l3_hit.attr.attr,
> +	&fme_perf_event_vtd_sip_slpwc_l4_hit.attr.attr,
> +	&fme_perf_event_vtd_sip_rcc_hit.attr.attr,
> +	&fme_perf_event_vtd_sip_iotlb_4k_miss.attr.attr,
> +	&fme_perf_event_vtd_sip_iotlb_2m_miss.attr.attr,
> +	&fme_perf_event_vtd_sip_iotlb_1g_miss.attr.attr,
> +	&fme_perf_event_vtd_sip_slpwc_l3_miss.attr.attr,
> +	&fme_perf_event_vtd_sip_slpwc_l4_miss.attr.attr,
> +	&fme_perf_event_vtd_sip_rcc_miss.attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group fme_perf_vtd_sip_events_group = {
> +	.name = "events",
> +	.attrs = fme_perf_vtd_sip_events_attrs,
> +	.is_visible = fme_perf_events_visible,
> +};
> +
> +static const struct attribute_group *fme_perf_events_groups[] = {
> +	&fme_perf_basic_events_group,
> +	&fme_perf_cache_events_group,
> +	&fme_perf_fabric_events_group,
> +	&fme_perf_vtd_events_group,
> +	&fme_perf_vtd_sip_events_group,
> +	NULL,
> +};
> +
> +static struct fme_perf_event_ops *get_event_ops(u32 evtype)
> +{
> +	if (evtype > FME_EVTYPE_MAX)
> +		return NULL;
> +
> +	return &fme_perf_event_ops[evtype];
> +}
> +
> +static void fme_perf_event_destroy(struct perf_event *event)
> +{
> +	struct fme_perf_event_ops *ops = get_event_ops(event->hw.event_base);
> +	struct fme_perf_priv *priv = to_fme_perf_priv(event->pmu);
> +
> +	if (ops->event_destroy)
> +		ops->event_destroy(priv, event->hw.idx, event->hw.config_base);
> +}
> +
> +static int fme_perf_event_init(struct perf_event *event)
> +{
> +	struct fme_perf_priv *priv = to_fme_perf_priv(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct fme_perf_event_ops *ops;
> +	u32 eventid, evtype, portid;
> +
> +	/* test the event attr type check for PMU enumeration */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * fme counters are shared across all cores.
> +	 * Therefore, it does not support per-process mode.
> +	 * Also, it does not support event sampling mode.
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	eventid = get_event(event->attr.config);
> +	portid = get_portid(event->attr.config);
> +	evtype = get_evtype(event->attr.config);
> +	if (evtype > FME_EVTYPE_MAX)
> +		return -EINVAL;
> +
> +	hwc->event_base = evtype;
> +	hwc->idx = (int)eventid;
> +	hwc->config_base = portid;
> +
> +	event->destroy = fme_perf_event_destroy;
> +
> +	dev_dbg(priv->dev, "%s event=0x%x, evtype=0x%x, portid=0x%x,\n",
> +		__func__, eventid, evtype, portid);
> +
> +	ops = get_event_ops(evtype);
> +	if (ops->event_init)
> +		return ops->event_init(priv, eventid, portid);
> +
> +	return 0;
> +}
> +
> +static void fme_perf_event_update(struct perf_event *event)
> +{
> +	struct fme_perf_event_ops *ops = get_event_ops(event->hw.event_base);
> +	struct fme_perf_priv *priv = to_fme_perf_priv(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 now, prev, delta;
> +
> +	now = ops->read_counter(priv, (u32)hwc->idx, hwc->config_base);
> +	prev = local64_read(&hwc->prev_count);
> +	delta = now - prev;
> +
> +	local64_add(delta, &event->count);
> +}
> +
> +static void fme_perf_event_start(struct perf_event *event, int flags)
> +{
> +	struct fme_perf_event_ops *ops = get_event_ops(event->hw.event_base);
> +	struct fme_perf_priv *priv = to_fme_perf_priv(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 count;
> +
> +	count = ops->read_counter(priv, (u32)hwc->idx, hwc->config_base);
> +	local64_set(&hwc->prev_count, count);
> +}
> +
> +static void fme_perf_event_stop(struct perf_event *event, int flags)
> +{
> +	fme_perf_event_update(event);
> +}
> +
> +static int fme_perf_event_add(struct perf_event *event, int flags)
> +{
> +	if (flags & PERF_EF_START)
> +		fme_perf_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static void fme_perf_event_del(struct perf_event *event, int flags)
> +{
> +	fme_perf_event_stop(event, PERF_EF_UPDATE);
> +}
> +
> +static void fme_perf_event_read(struct perf_event *event)
> +{
> +	fme_perf_event_update(event);
> +}
> +
> +static void fme_perf_setup_hardware(struct fme_perf_priv *priv)
> +{
> +	void __iomem *base = priv->ioaddr;
> +	u64 v;
> +
> +	/* read and save current working mode for fabric counters */
> +	v = readq(base + FAB_CTRL);
> +
> +	if (FIELD_GET(FAB_PORT_FILTER, v) == FAB_PORT_FILTER_DISABLE)
> +		priv->fab_port_id = FME_PORTID_ROOT;
> +	else
> +		priv->fab_port_id = FIELD_GET(FAB_PORT_ID, v);
> +}
> +
> +static int fme_perf_pmu_register(struct platform_device *pdev,
> +				 struct fme_perf_priv *priv)
> +{
> +	struct pmu *pmu = &priv->pmu;
> +	char *name;
> +	int ret;
> +
> +	spin_lock_init(&priv->fab_lock);
> +
> +	fme_perf_setup_hardware(priv);
> +
> +	pmu->task_ctx_nr =	perf_invalid_context;
> +	pmu->attr_groups =	fme_perf_groups;
> +	pmu->attr_update =	fme_perf_events_groups;
> +	pmu->event_init =	fme_perf_event_init;
> +	pmu->add =		fme_perf_event_add;
> +	pmu->del =		fme_perf_event_del;
> +	pmu->start =		fme_perf_event_start;
> +	pmu->stop =		fme_perf_event_stop;
> +	pmu->read =		fme_perf_event_read;
> +	pmu->capabilities =	PERF_PMU_CAP_NO_INTERRUPT |
> +				PERF_PMU_CAP_NO_EXCLUDE;
> +
> +	name = devm_kasprintf(priv->dev, GFP_KERNEL, "fme%d", pdev->id);
> +
> +	ret = perf_pmu_register(pmu, name, -1);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void fme_perf_pmu_unregister(struct fme_perf_priv *priv)
> +{
> +	perf_pmu_unregister(&priv->pmu);
> +}
> +
> +static int fme_perf_init(struct platform_device *pdev,
> +			 struct dfl_feature *feature)
> +{
> +	struct fme_perf_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	priv->ioaddr = feature->ioaddr;
> +	priv->id = feature->id;
> +
> +	ret = fme_perf_pmu_register(pdev, priv);
> +	if (ret)
> +		return ret;
> +
> +	feature->priv = priv;
> +	return 0;
> +}
> +
> +static void fme_perf_uinit(struct platform_device *pdev,
> +			   struct dfl_feature *feature)
> +{
> +	struct fme_perf_priv *priv = feature->priv;
> +
> +	fme_perf_pmu_unregister(priv);
> +}
> +
> +const struct dfl_feature_id fme_perf_id_table[] = {
> +	{.id = FME_FEATURE_ID_GLOBAL_IPERF,},
> +	{.id = FME_FEATURE_ID_GLOBAL_DPERF,},
> +	{0,}
> +};
> +
> +const struct dfl_feature_ops fme_perf_ops = {
> +	.init = fme_perf_init,
> +	.uinit = fme_perf_uinit,
> +};
> diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
> index 6685c8e..4195dd6 100644
> --- a/drivers/fpga/dfl-fme.h
> +++ b/drivers/fpga/dfl-fme.h
> @@ -38,5 +38,7 @@ struct dfl_fme {
>  extern const struct dfl_feature_ops fme_global_err_ops;
>  extern const struct dfl_feature_id fme_global_err_id_table[];
>  extern const struct attribute_group fme_global_err_group;
> +extern const struct dfl_feature_ops fme_perf_ops;
> +extern const struct dfl_feature_id fme_perf_id_table[];
>  
>  #endif /* __DFL_FME_H */
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 9f0e656..d312678 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -197,12 +197,14 @@ struct dfl_feature_driver {
>   *		    feature dev (platform device)'s reources.
>   * @ioaddr: mapped mmio resource address.
>   * @ops: ops of this sub feature.
> + * @priv: priv data of this feature.
>   */
>  struct dfl_feature {
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	const struct dfl_feature_ops *ops;
> +	void *priv;
>  };
>  
>  #define DEV_STATUS_IN_USE	0
> -- 
> 1.8.3.1
> 

For the fpga part, looks good to me. Let me take a look at the rest.

Thanks,
Moritz
