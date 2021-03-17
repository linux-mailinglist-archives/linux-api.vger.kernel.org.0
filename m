Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF133F7CB
	for <lists+linux-api@lfdr.de>; Wed, 17 Mar 2021 19:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhCQSEW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Mar 2021 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhCQSEB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Mar 2021 14:04:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA5C06174A;
        Wed, 17 Mar 2021 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=4QwC8UMS+nJnHmskr7LNZ2HV/LtagcV2mJbub+zYcoY=; b=todkWTQikycgQ0XI3EHViChnZK
        qYj25fNZAKH1YtdtcxpZXTsREoqbJV36iYf5TrsQdNTT6bz0psCWPvD7akWL9W+G9glN/gGr550dY
        X1ZPpYn1wFKbKzyp2qzRVCzmUJSs/o1IrEUjFo3jXOLOi/KjMX7hEphoH4CCgPKQDy4pg3Qf9RvJc
        qeFKuil2MhCc/s4Sk9Qyu6kpOAOtYwKD+5wgBQqhMRbsGDb6QVHeuiSw6KaCwDq9sDrTv1HbhOaB1
        EjCxmsRN8PQVb5ZgSCGPvGoVvxinTARx5ZPCJn+moz4tKCG0h9QDN+oLrbLd7vlo45SG/60xb+Xkk
        EZJqL+LA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaWU-001fkv-EP; Wed, 17 Mar 2021 18:03:58 +0000
Subject: Re: [PATCH net-next v1] misc: Add Renesas Synchronization Management
 Unit (SMU) support
To:     min.li.xe@renesas.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <1616003094-1701-1-git-send-email-min.li.xe@renesas.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5469b337-c210-617d-f88c-519e773f99b6@infradead.org>
Date:   Wed, 17 Mar 2021 11:03:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1616003094-1701-1-git-send-email-min.li.xe@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/17/21 10:44 AM, min.li.xe@renesas.com wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f532c59..1e2bc33 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -445,6 +445,16 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config RSMU
> +	tristate "Renesas Synchronization Management Unit (SMU)"
> +	depends on MFD_RSMU_I2C || MFD_RSMU_SPI
> +	help
> +	  This option enables support for the IDT ClockMatrix(TM) and 82P33xxx
> +	  families of timing and synchronization devices.It will be used by

	                                         devices. It

> +	  Renesas PTP Clock Manager for Linux (pcm4l) software to provide support
> +	  for GNSS assisted partial timing support (APTS) and other networking
> +	  timing functions.


-- 
~Randy

