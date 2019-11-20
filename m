Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB92110370B
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfKTJzy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 04:55:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33206 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfKTJzy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Nov 2019 04:55:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so26809633ljk.0;
        Wed, 20 Nov 2019 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+hNiuBFTxFlT0Gn7HpVHOGwMsYYl+Y2vlqsxw0K/O/0=;
        b=iK5N/l9nxKs5b5R2Kn8vtngSjrarNyucoYFtwE5updxFTIhfNTxuPZEjTBx1DMBc72
         CbTnVTg2uWK7akJGoClK0xS1L8NxevemktiXSgWMpQ5J7UUQTjYPmCCjWdNGRWU3Cadz
         Pdmt3jZ0qChONxCupdToTTRaYZirP/yxm2djAZfZo5eVMSKN+AwzhHKN4cE0aPp9BKG8
         iqFmW4N2bTlFKmflYhlWdVoSV8sxSe5cmNNw0IrPxSwNhDm4OmdpZJsnM1eHl8YyWauN
         7WMRKfzD2V/C7Wjz3ab8UwQraDl0RFveJ5yDlB5r+xpXX+EEeK7Dd97PyQoIpV1LCGxA
         Hd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+hNiuBFTxFlT0Gn7HpVHOGwMsYYl+Y2vlqsxw0K/O/0=;
        b=C0ElHSwlNRj8cnd96RTc37hmUG3AjSXSstIw8e3qlgWmgtdx8/L7QdHeSgWw55zt4t
         8UJ+Fhps70mXn6WVbF3W+aYGv6ELjHE0JzEFyz8ztv5W8mFX1LZWnPD4Hm1dmAlwp809
         Q/fSzX/Qdw8WUvzXIj+QvudI8gTax5w+MMhshCl/wvbcjauhQ41YOyZR2luQ+mQFGtYt
         2TYDt5LuukqD3Un3n2JNjiCoh+7YR4WyyvRJskiwgBiQ1FVmFxuLymdOg0WnWeFaohpF
         R+oBpCoyV74B6uaHYpKIo2gR8iSlg9qa7l/ZxrYjRUzPKxBlhN7F6TaoLkzSpryEAezS
         jRUA==
X-Gm-Message-State: APjAAAW0/u1W+c74Q5Aec95CnpH8iODmfMBv1mUQWf1UMaa54XZM/pGl
        Rc8uMBWWTW2caFUcdpvcgs0=
X-Google-Smtp-Source: APXvYqz5XLNYfo58m05t+AYNzcCs3uopADtVc8oldaT36Eb4G0H4JrkEoSj0caIgNfCD+Js/Fvjzhw==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr1909572ljn.88.1574243750093;
        Wed, 20 Nov 2019 01:55:50 -0800 (PST)
Received: from ?IPv6:2a02:17d0:4a6:5700:d63d:7eff:fed9:a39? ([2a02:17d0:4a6:5700:d63d:7eff:fed9:a39])
        by smtp.googlemail.com with ESMTPSA id f3sm1481438lfl.58.2019.11.20.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:55:49 -0800 (PST)
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de>
 <CALCETrUKDO1LSMnHNcPiAFQh2ri6saRiRBi9b5e699cm1_Mgsw@mail.gmail.com>
 <20191119124150.GB1975017@kroah.com>
 <19681012.svDddlc5pN@positron.chronox.de>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <cdf1791d-0e60-cb9f-6030-0258f12bef3c@gmail.com>
Date:   Wed, 20 Nov 2019 14:55:46 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <19681012.svDddlc5pN@positron.chronox.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

20.11.2019 13:58, Stephan Müller пишет:

> Or another idea and apologies if I restart this conversation as there was
> already a discussion around it: what about extending the getrandom(2) call
> instead of adding a device file?
> 
> What about adding yet another flag to getrandom: GRND_TRUERANDOM and process
> it as follows:
> 
>          if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE|
> GRND_TRUERANDOM))
>                  return -EINVAL;
> 
>          //From Andy's tree
>          /*
>           * Requesting insecure and blocking randomness at the same time makes
>           * no sense.
>           */
>          if ((flags & (GRND_INSECURE|GRND_RANDOM)) == (GRND_INSECURE|
> GRND_RANDOM))
>                  return -EINVAL;
> 
> 	  /* We only allow GRND_TRUERANDOM by itself or with NONBLOCK */
> 	  if (! ((flags & GRND_TRUERANDOM) &&
>                 ((flags == GRND_TRUERANDOM) ||
>                  (flags == GRND_TRUERANDOM | GRND_NONBLOCK))))
> 		return -EINVAL;
> 
> 	if (flags & GRND_TRUERANDOM) {
> 		... do the TRNG processing ...
> 		... may return -ENOPNOTSUPP if no TRNG available ...
> 	}

This would totally miss the point of adding a device node: UNIX 
permissions that don't allow "others" to read and deplete "true" random 
numbers.

-- 
Alexander E. Patrakov
