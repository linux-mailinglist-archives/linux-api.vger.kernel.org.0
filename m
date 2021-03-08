Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5F330C4F
	for <lists+linux-api@lfdr.de>; Mon,  8 Mar 2021 12:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhCHL2R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Mar 2021 06:28:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36404 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhCHL2O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Mar 2021 06:28:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128BS1M1090144;
        Mon, 8 Mar 2021 05:28:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615202881;
        bh=q0Z0r2uMokg2qUPUFmiAW5LN8g55+RfYbTn+m396kSA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uCgk7gvtOGggg8kk38QXHDyThtcIikyMFrTSOvrwrqNzxe9kQf3chRR/spzJW1Iee
         tG5cqN09fQa/4vMRxYKKIyZCKevWfmZ4Kn++IyrSVsay7ZpXvDE0JPBefS/cVwkGTF
         vgxnViTbwvyoG7yMhMbzgWsRd3DvjVljNgOJnSLk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128BS1Yk093808
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 05:28:01 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 05:28:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 05:28:01 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 128BRwbB109813;
        Mon, 8 Mar 2021 05:27:59 -0600
Subject: Re: [PATCH] mtd: add OTP (one-time-programmable) erase ioctl
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <Tudor.Ambarus@microchip.com>
References: <20210303201819.2752-1-michael@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <d3187aaf-e1cd-5778-eca7-9dc41f3827b0@ti.com>
Date:   Mon, 8 Mar 2021 16:57:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303201819.2752-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 3/4/21 1:48 AM, Michael Walle wrote:
> This may sound like a contradiction but some SPI-NOR flashes really
> support erasing their OTP region until it is finally locked. Having the
> possibility to erase an OTP region might come in handy during
> development.
> 
> The ioctl argument follows the OTPLOCK style.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>


[...]

Regards
Vignesh

