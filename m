Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7541AD41
	for <lists+linux-api@lfdr.de>; Sun, 12 May 2019 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfELRFT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 May 2019 13:05:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43251 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfELRFT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 May 2019 13:05:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id t187so4396930oie.10
        for <linux-api@vger.kernel.org>; Sun, 12 May 2019 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSdaCWlLqhcDnznsymm2aG1Z95spPWEN1cuWFhXTYhg=;
        b=M1kb+HIzVOLjPCV4h6Pn4lve+FlnoRhh7JL/WOdRAHWhP7XRiXt2Sb1zCx+P73FWpH
         KH+vO3XX2/+B76I47eV+x5dE3f6pnMgrTIJE7VNh4ZChznUcTJY9sLB9hecdROdExjmg
         /JPQRL9+WNauQRy09PAuL4L+fpknOrj50gkModVL0BMNekoH7GBXdRdXfxoaLcWOG03L
         Y+O3tl58C2QvVdDq9MUnLdKYMn7lI9M9GE8l5NKOH1AX/WldekcH2nLERHsnEiX4sVsK
         tDUJ/uw9Na9lpPhy3YjlBknNgRsJ/+qzkinLg8HkU903BWLWhwIYA6J1YzU1WDzc0gEI
         hjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSdaCWlLqhcDnznsymm2aG1Z95spPWEN1cuWFhXTYhg=;
        b=T7YhcrQKxc5k36Xn+ufeGLt3S/QWRiZhSpClo/qhU5A31wrlFirrdlXYI5JJAyfx2j
         kI6J4uYT5HLfcd1XKDFOIMGIcywQ8TxKlRgo0EWBsatIFF7CBvTerX7RKfxofSc1EY8R
         J+JdsmPr4YgETHQYfanDDGHWHvWo/tZVThLd++fovR8xG9FVDw8Tc8s7V3G5G6shdOVS
         ZatVuZpZ+92m74p5glZfLKj14BTXmZQktoXits1EvCvfFrVXjQibs7ItrhoukKEBOmgF
         HVQKaLUeB8Y6vbQwI0emA/6NnbzAGfzgfpb6kOA3QZcvbgqm2XS5UQI/HvADj9fxGi5x
         ukXg==
X-Gm-Message-State: APjAAAVaSeU9XNbKjUXClKTmLkYBmOFF7tKHt2YrN8ykBwffF9uiqsTY
        PuOMcPOOz5n7w7iT/D78CUCoWQ==
X-Google-Smtp-Source: APXvYqyWbK23VrEkToZOwoQB+/N6sOOi7C92304sjVSrsw7En9uosUTt+tMWJRIvjnvIj1tmphPF2Q==
X-Received: by 2002:aca:e594:: with SMTP id c142mr3854397oih.155.1557680718422;
        Sun, 12 May 2019 10:05:18 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id w192sm4456571oiw.57.2019.05.12.10.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:05:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190512091748.s6fvy2f5p2a2o6ja@isilmar-4.linta.de>
 <1557665567.10635.222.camel@linux.ibm.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
Date:   Sun, 12 May 2019 12:05:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557665567.10635.222.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/12/19 7:52 AM, Mimi Zohar wrote:
> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
>>> This proposal consists in marshaling pathnames and xattrs in a file called
>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
>>> been extracted.
>>
>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
>> be done equivalently by the initramfs' /init? Why is kernel involvement
>> actually required here?
> 
> It's too late.  The /init itself should be signed and verified.

If the initramfs cpio.gz image was signed and verified by the extractor, how is
the init in it _not_ verified?

Rob
