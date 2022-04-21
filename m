Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285E50A45B
	for <lists+linux-api@lfdr.de>; Thu, 21 Apr 2022 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390194AbiDUPja (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Apr 2022 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390181AbiDUPj1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Apr 2022 11:39:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262847066;
        Thu, 21 Apr 2022 08:36:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k22so7259736wrd.2;
        Thu, 21 Apr 2022 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvKv13ZK3iFa+2L/yU8R/npHJfHQ8PQo4T/Wi4XzLzI=;
        b=ihHXZKvLqJCw831yeo6ujJoTlq4JGDUMT/hg1HDQQZ2bNiIIsCB2OCJPtXDasltQ5E
         vxtlebMh5qnPqQQphqFb9hjWwahipK3b8bsW5JHXuqekYBVXeRUuYEEZJ0waZ345Uowr
         mhGe1+HZYi/OMYxV2JAgam2pLDQilgiMyiwrHZDB711FFnW6y7awM0SXsfaC/6SwTFGL
         kylyGAyc5XwLkw5au63A9+hayKno9omVNp5/OuHVv4nlRl/Nf/ysJY4BhKlOHzy0iNe8
         m9q+tEUWVG6MZy6YI2iuSgjXekfj2KzMACa7MNCKBC3tuudI9D8B25HcxrbbofqFL15x
         NcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvKv13ZK3iFa+2L/yU8R/npHJfHQ8PQo4T/Wi4XzLzI=;
        b=FHu63npKWANPzHfQleC/8oSzeCa1fV5LpqTe7ZWe6kxZRX6RP9z5TzSbRNF0Y8nNDC
         jZM52lQcwchmyVIBu4gKoO3kuPr9GMBYelkdNKqFPblIhXUPesfF3tugCmsrQ+6lkgCo
         iN/4EUEignDDnixyDOAXFnuHeRsjaFoaYx6SJq7NansdMaQBB3mnGWb+Nv7s2IJlEBe8
         MwV3FyKg/lRHGB7mW9sEeVXQ3XKR3oKzaFWUfV+HrIVR0lKvJUgZltqu/JAQ3jPH4jTN
         uWV/xx6XrykFvGdBpS5ASJdTE31qSKuyX9a/GSje7ePHoHWMtIL22U/002qCQWDcR8Rv
         rXTg==
X-Gm-Message-State: AOAM5338RHretoiFNKaBc8pcQxV9fOkPYR9vtU6CXnVH0yEtrY2mopkr
        XX1dTIpu4FGvernk1OdjRFY=
X-Google-Smtp-Source: ABdhPJztLbxi1p6Vq0IAkoh6pzN37oVEH4QuhuyDAMFC4R1nwZ2ZF5CZi6DbA7oSLOWednr9ZxIqog==
X-Received: by 2002:a5d:490a:0:b0:207:b3d0:18d6 with SMTP id x10-20020a5d490a000000b00207b3d018d6mr221037wrq.503.1650555395952;
        Thu, 21 Apr 2022 08:36:35 -0700 (PDT)
Received: from alfredos.. ([2a0c:5a84:3610:e200:8a88:88ff:fe88:8788])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6d88000000b0020a8d0d0076sm2792248wrs.68.2022.04.21.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:36:35 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     ilpo.jarvinen@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com, giulio.benetti@micronovasrl.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        heiko@sntech.de, jirislaby@kernel.org, johan@kernel.org,
        linux-api@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
Date:   Thu, 21 Apr 2022 17:36:26 +0200
Message-Id: <20220421153626.120494-1-vicencb@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Hello Ilpo,

i have tested your v3 patch on v3 hardware, that is, using the
emulated em485 because of lack of HW support. It is not working
due to three issues.

1.- rs485_stop_tx is never called because there are no interrupts.
I worked around this by disabling DMA:

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -577,3 +577,3 @@ static int dw8250_probe(struct platform_device *pdev)
 		data->data.dma.rxconf.src_maxburst = p->fifosize / 4;
 		data->data.dma.txconf.dst_maxburst = p->fifosize / 4;
- 		up->dma = &data->data.dma;
+		up->dma = 0; // Proof of concept, not to be merged!

2.- Although "linux,rs485-enabled-at-boot-time" is set in the DTS,
the RTS/DriverEnable line is asserted all the time the /dev/ttyS1
device file is closed.
As soon as the device file is openned, the RTS line is deasserted.
Then it works as expected: it is asserted only during transmissions.
When the device file is closed again, the RTS line goes back to the
asserted level and stays there.
When the rs485 mode is enabled, it is expected that the RTS line be
deasserted by default.

3.- The RTS line is asserted a few microseconds earlier than the
start bit, that is acceptable, but then it deasserts one whole bit
time before the last stop bit.
So, the last stop bit of the last byte of a message is not sent
because the driver is disabled.
This has been tested with the port configured at 19200e1, that is,
the bit time is 52 us.
I worked around this by adding "rs485-rts-delay = <0 52>;" in the
DTS. This leads to the following feature (not an issue):

On Mon, 11 Apr 2022 11:33:12 +0300, Ilpo Järvinen wrote:
> Set delay_rts_before_send and delay_rts_after_send to zero for now.
> The granularity of that ABI is too coarse to be useful.

Indeed the time unit of this parameter is milliseconds, as stated in
Documentation/devicetree/bindings/serial/rs485.yaml
Which in the general case is more than ten bit times.

But it is being interpreted as microseconds here:

On Mon, 11 Apr 2022 11:33:11 +0300, Ilpo Järvinen wrote:
> [PATCH v3 02/12] serial: 8250: Handle UART without interrupt on TEMT
>+	stop_delay += (u64)p->port.rs485.delay_rts_after_send * NSEC_PER_USEC;

So, this way it has a useful granularity to be used in
"rs485-rts-delay = <0 52>;" but is not compliant with the spec.

Regards,
  Vicente.
