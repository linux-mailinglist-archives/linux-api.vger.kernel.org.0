Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB433A3F5
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhCNJpJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Mar 2021 05:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhCNJoe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Mar 2021 05:44:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D056C061574
        for <linux-api@vger.kernel.org>; Sun, 14 Mar 2021 01:44:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g8so6316705wmd.4
        for <linux-api@vger.kernel.org>; Sun, 14 Mar 2021 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dewlM8ok+0vz7euretSLFHwtIdlMmbD+BlGNP+6IS3A=;
        b=Dctv70yT5IspbMlgPcSUSZBZdIg3Ff+d78kMStA4irU9eu6j4aGsTo4vlGUp1kAxTV
         BIfCGjZQ3eMohZY/aVBlBCf+xQbI8GHSYaTZkuW20OxjMnfTFBzmZBYCIC3Oy7nkYSLr
         4vHkkVyidfyVPkf+w51tUYXcAMM26P09/N2a14AnW2mN9TUyWAk2tw0tY0nrJxpGl+pE
         jAhBL5VbWH+bL87CTrJS0YTWeEcxOU9J0t5C+U91FoWzRTM3lqzLTu6uctYrajswhXzf
         b0wrE0lXMRYWkq1nGhiy2mh5VdgxlbqX4EfxZXZuNPsBsdRSh2nBf2SuP4i86lVFMXHl
         w5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dewlM8ok+0vz7euretSLFHwtIdlMmbD+BlGNP+6IS3A=;
        b=DEleHW9FJm0ICy3Ql+UrGusW21Z0idzC0XBUHAg9TpN55XtktAdLJtIvLe40gb3gQ+
         s0LgzBLPtDCi6DEaAEKccUSJLp59tDFNM1WiR0f4+CtrbFmqOhDMEN9Z7W3FLce/amcg
         j6SxkPB/LAdIs8pINZ8jDqo/RmnoEFs0kedVFm/qA5GpanYaQ2hVxjpRHsNKDkokSRIE
         Cz+iRIS6ZVKGPPsF2YWsU0NuoiBx1A5Pu6Kdy6GXgBDKZwI6GUGA17nEYnqlHzy5otuA
         GLCmDMrTXrzgdKgyUsWUbVuh7cBxkR/WAQHltztkIIcehxOCfh/KxzRwKrDMgelIy1sU
         S0Gw==
X-Gm-Message-State: AOAM531bE+elHoQQv9fh8UpDK/ILziRq7hfvQ71Yl6gTkInZwIsLNa49
        0i9SRwKC09zaQAzmamscC+w=
X-Google-Smtp-Source: ABdhPJztDiLeA2/pJWeUA3+1rM1hwn99ImO53gx4iN99arHbQ+NYYmrlCodepyJwF1tV5F6Sf6J/nQ==
X-Received: by 2002:a05:600c:3515:: with SMTP id h21mr1615812wmq.9.1615715072721;
        Sun, 14 Mar 2021 01:44:32 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id s18sm16830739wrr.27.2021.03.14.01.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 01:44:32 -0800 (PST)
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Otto Moerbeek <otto@drijf.net>, Coreutils <coreutils@gnu.org>
Cc:     Fabrice BAUZAC <noon@mykolab.com>, juli@clockworksquid.com,
        Jeffrey Walton <noloader@gmail.com>,
        freebsd-hackers@freebsd.org,
        William Ahern <william@25thandclement.com>,
        Roman Czyborra <roman@czyborra.com>, oshogbo@freebsd.org,
        tech@openbsd.org, Christian Groessler <chris@groessler.org>,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>, ed@nuxi.nl,
        Eric Pruitt <eric.pruitt@gmail.com>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com>
 <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com>
 <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <48228481-c1b0-dcce-8598-4c88aedb2ef9@gmail.com>
Date:   Sun, 14 Mar 2021 10:44:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 1/25/21 5:03 AM, Bernhard Voelker wrote:
> OTOH I understand that there's a little gap in the tool landscape.
> Astonishingly, there doesn't seem to exist a trivial tool to redirect
> from standard input (or any other input file descriptor) to a file.
> I wrote such a little tool in the attached:
> 
>    $ src/sink --help
>    Usage: src/sink [OPTION]... FILE
>    Copy input stream to FILE.
> 
>    Mandatory arguments to long options are mandatory for short options too.
> 
>      -a, --append              append to the given FILE, do not overwrite
>      -c, --create              ensure to create FILE, error if exists
>      -i, --input-stream=FD     read from stream FD instead of standard input
> 
>    The default input stream number FD is 0, representing the standard input.
> 
> This allows not only to copy data from standard input, but from any
> file descriptor open for reading.  It also allows control over
> how the output file will be opened (e.g. with O_CREAT|E_EXCL).
> 
> The OPs case would look like:
> 
>    echo 'foo' | sudo sink /etc/foo
> or
>    echo 'foo' | sudo sink -a /etc/foo  # append.
> or
>    echo 'foo' | sudo sink -c /etc/foo  # ensure creation of the file.
> 
> I'm not sure if this will ever be considered for inclusion -
> I just did it "for fun". ;-)
> 
> Have a nice day,
> Berny
> 

By chance, I just found out that there is a tool very similar to 'sink' 
in moreutils [1].  It's called 'sponge'.

[1]: <https://joeyh.name/code/moreutils/>

So this feature already exists, and therefore I drop my patches.

Cheers,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
