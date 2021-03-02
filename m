Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCD32B2F3
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhCCDCn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446119AbhCBNQl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 08:16:41 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7AC061756;
        Tue,  2 Mar 2021 05:06:35 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E185F2223E;
        Tue,  2 Mar 2021 14:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614690394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTtVJwCrMEqy04BVWxGgfe8sOuG6CbjO06VOyD60coI=;
        b=N1jbqwuLG9dlRICo7gv/InhS3T3Z95hbPGXGxPecFPDxLjOzwAI+8oh76X1nIWpyGQ2wmh
        OjSHejnJe9fVnQlH2KmDVlcC0agYzilguPEGV3Cdql6nJfCD+mnu+UXiMaR8uX6lTzbNV1
        ihERZ3CaUUAkTDmpjPY6Im1R8EIIm9o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Mar 2021 14:06:33 +0100
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor.Ambarus@microchip.com
Subject: Re: [RFC PATCH] mtd: add OTP (one-time-programmable) erase ioctl
In-Reply-To: <20210302134617.5aa78cc4@xps13>
References: <20210302110927.6520-1-michael@walle.cc>
 <20210302134617.5aa78cc4@xps13>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <05c255e6d9d8d12e8e6af59d9c153981@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Am 2021-03-02 13:46, schrieb Miquel Raynal:
> Michael Walle <michael@walle.cc> wrote on Tue,  2 Mar 2021 12:09:27
> +0100:
> 
>> This may sound like a contradiction but some SPI-NOR flashes really
>> support erasing their OTP region until it is finally locked. Having 
>> the
>> possibility to erase an OTP region might come in handy during
>> development.
>> 
>> The ioctl argument follows the OTPLOCK style.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> OTP support for SPI-NOR flashes may be merged soon:
>> https://lore.kernel.org/linux-mtd/20210216162807.13509-1-michael@walle.cc/
>> 
>> Tudor suggested to add support for the OTP erase operation most 
>> SPI-NOR
>> flashes have:
>> https://lore.kernel.org/linux-mtd/d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com/
>> 
>> Therefore, this is an RFC to get some feedback on the MTD side, once 
>> this
>> is finished, I can post a patch for mtd-utils. Then we'll have a 
>> foundation
>> to add the support to SPI-NOR.
>> 

[..]

>> +int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t 
>> len)
>> +{
>> +	struct mtd_info *master = mtd_get_master(mtd);
>> +
>> +	if (!master->_erase_user_prot_reg)
>> +		return -EOPNOTSUPP;
>> +	if (!len)
>> +		return 0;
> 
> Should we add a sanity check enforcing that we don't try to access
> beyond the end of the OTP area?

This is checked in the op itself, as it is done for all the
other OTP read/write/lock ops.

Right at the moment, I don't see how this could be achieved in
an elegant way. Without additional changes, you'd have to call
mtd_get_user_prot_info() and iterate over the returned values
and figure out whether from and len are valid.

[..]

-michael
