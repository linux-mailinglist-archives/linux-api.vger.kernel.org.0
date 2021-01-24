Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508C2301D79
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 17:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAXQW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 11:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbhAXQW5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 11:22:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42BDC061574
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 08:22:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c12so9860233wrc.7
        for <linux-api@vger.kernel.org>; Sun, 24 Jan 2021 08:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tge0WSYAniqWcuAqFQnVZg2cTSD1QDk4FhLRTYjLR/s=;
        b=Hw1B4e8N4Fe0pkBG5w5A00v/NQXUIeI5wICQUupXjU9s/3kwC+Pv5gXEam5e32vHW6
         RLBEAe4jtzdzkOFlxfuYteJKaUKFx9CI0mK6Ml8akTeGMn8N4jfVdMUt3kOAOccXhkq8
         ZDNYIrP6CAMN8Z7Dd8k2f3Z7oWA1YxvbaW/UlDlhMZZ/MOttbHETOMY4e18Hg4hmt8aN
         Ka/g94XafB6BnRJsMrOHIaWEMz/Uv+9JHFxCJoIMmaBJ841cG/uQyguir6pPlzZ1VfQe
         FpjM/vhpzicQmcN/2NPlEZj4yZ95k3JVhOZh0+vG0xU7fhI3A88zMmMIq7QN9eGacVKg
         s3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tge0WSYAniqWcuAqFQnVZg2cTSD1QDk4FhLRTYjLR/s=;
        b=mu790C5OCz35bjeYbmce76n2cXbp45OMUXPsTu2/n85bsyJ2yTK7q61mlHvON45u17
         38r2sk+WOiY5Y8Cdzl+gxavzwqVgHZEpMc8x6ktiBh3u8uqoJjfBbTK1oHfrDddi6Lwp
         Sj9h6rYbpzVDTPO4VXMJUH9XOarECE+4GjOWThjbV/AEOX+ifgncWzRkIuC/28o/6xjf
         umn8U5Db8WhtfkzP8M2PfXrPGgi/QzSXx3Ub+imxiRFsppaQ9vNW9ohn1NIh09KFSKEv
         dyj8KveDc8WdgKFXzceTTVtvW2FsFYNbPCCKnlWE6V3SvXtvvr7sHzE65HpsXgtcUnKi
         YFYw==
X-Gm-Message-State: AOAM5316SIfQV1/KyXY6SJRw1pkCaJYV7i+pYQtE7Zz8CtJ2GwXUVS2e
        +4o+gf67G4gfAudX9uhuI0U=
X-Google-Smtp-Source: ABdhPJzah+Qs57CJ90w5Xcthn9uI2Ga35mInii4uiYXL7Lh/wrq5xV+wEAkXzh1Uo+K4kvxPo1y74g==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr13294309wrp.172.1611505335449;
        Sun, 24 Jan 2021 08:22:15 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with UTF8SMTPSA id s24sm18380903wmh.22.2021.01.24.08.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 08:22:12 -0800 (PST)
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     Teran McKinney <sega01@go-beyond.org>
Cc:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        P??draig Brady <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com> <YA2cNr/BQw1fAhwn@daemon>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <c2bd6b56-1ff6-9893-962f-501334ef8694@gmail.com>
Date:   Sun, 24 Jan 2021 17:22:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <YA2cNr/BQw1fAhwn@daemon>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/24/21 5:11 PM, Teran McKinney wrote:
> On 2021-01-24 13-18-46    , Alejandro Colomar wrote:
>> This is useful for using tee to just write to a file,
>> at the end of a pipeline,
>> without having to redirect to /dev/null
>>
>> Example:
>>
>> echo 'foo' | sudo tee -q /etc/foo;
>>
>> is equivalent to the old (and ugly)
>>
>> echo 'foo' | sudo tee /etc/foo >/dev/null;
>>
>> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
>> ---
[...]
> 
> Hi,
> 
> Why is this a thing?
> 
> The point of tee is to write a file *and* to stdout. If you don't want use that, use:
> 
> `> file`
> 
> To overwrite.
> 
> Or
> 
> `>> file`
> 
> To append.
> 
> I guess the only reason this would be used is if you wanted to write
> multiple files at the same time, which tee supports.
> 
> -Teran
> 


Hi Teran,

The rationale is that protected files can't be modified with '>', unless
you give superuser rights to the whole shell.  If you want fine-grained
control over the rights of the tools in the pipeline, you'll come to
times where you want the write step to be the only one to have those,
and you can't [sudo >] nor [sudo >>], which by the way I would consider
an even better solution, but which would require much more work, and
designing a completely new idiom for it, which would face much more
objection too.

Regards,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
