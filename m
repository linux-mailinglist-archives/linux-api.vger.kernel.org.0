Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5730480B
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbhAZFwW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 00:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbhAYMpG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Jan 2021 07:45:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA304C0617A9
        for <linux-api@vger.kernel.org>; Mon, 25 Jan 2021 03:33:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m1so11288879wrq.12
        for <linux-api@vger.kernel.org>; Mon, 25 Jan 2021 03:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UndO6GMVVZmcMmeat9dl3kmBPjIg2CugQuFU3Qe+syA=;
        b=BWY1cdaIaXtNsoBI1CL94KUSaVZc4YPaLvwxnaI5Ua5JhJbzrpRNdhCerYVtrU/vqv
         naqE+1sI0m3ANvWz3eikFQG3a6drkyzg9oRE0aC0hSR88Y8nbIpRuRNozVSXwPhWM7Jr
         xCnkxyoXIIhvyCYVX0SEHW5+c4Faq76r0QXtfVPSChhuQ9SOmhQfDSEX8CLwmyc8AcRK
         U6q7izAK66I/7zFCIG6aoyTjyn7N2sT5CCl2bm2QSSVyITAGO4v+D5i9iMCDiq4dbEO8
         rqjA6OXfDhxeEU3KVflD77eud8imVjklpG496tjbKafd/y7/3cauqM8wggxiYx9jxF6b
         6e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UndO6GMVVZmcMmeat9dl3kmBPjIg2CugQuFU3Qe+syA=;
        b=j04JM57HHdmsaQvmrkdnxUXLcxei7UpLg7yj5TI1czdEU1DIk2149diQSG/se1ZQno
         a9CaM09x3sszFAt3hb5OcnFKoqYFtCP0NbwkJlnSY7FfDxWrsxJQLOvvZtCt4OySXc6T
         3aBA/QNHs0i6zKPdnK1P9a+pCeNE5I4mUSoALGHIIir5lbn7WJnYm8fgDH7/YXtLJttx
         tJxubJCTLGL2sh6nd1DMdPJb903X9bVOeN3Ff+9Avbvvcxmi/ogB7oIQBqoQVebz3azJ
         6NDYDAnyqP4dMn/7lhML/TcbXW1L3gMsPUE51vZG7MeE83sA8Z7NeWJfK2qnMc0GxgpA
         QkxQ==
X-Gm-Message-State: AOAM531DAmOMrSStcGpPWwc3SPoLqoTpIjWrqccRhVLPERYNz29wbwai
        zaKSU7gAabXeLXOIzhESG6c=
X-Google-Smtp-Source: ABdhPJxQajBxHs+X8bVvEq65CY8ZT27zqXuQFKWROK50rmJw6Ks4jGRr/doMBaLndHNsyL+8QrsRNQ==
X-Received: by 2002:adf:e348:: with SMTP id n8mr468706wrj.148.1611574416444;
        Mon, 25 Jan 2021 03:33:36 -0800 (PST)
Received: from [10.8.0.134] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id n6sm20254332wmi.23.2021.01.25.03.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 03:33:35 -0800 (PST)
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
Message-ID: <d0d1697b-7851-9078-289e-02ef76f3303a@gmail.com>
Date:   Mon, 25 Jan 2021 12:33:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/25/21 5:03 AM, Bernhard Voelker wrote:
> On 1/24/21 9:01 PM, Alex Henrie wrote:
>> I am definitely interested. Bernhard Voelker seemed to express
>> interest as well, conditional on -q being added to POSIX first.[1]
> 
> Just to clarify: I'm not as enthusiastic to add that option as it
> may have sounded.
> 
> Let me put it like this: if -q once gets standardized by POSIX,
> then we'd take it over in the GNU tee implementation.
> 
> Let me summarize so far:
> The suggestion is to solve the problem to save some data coming from
> a pipe as a different user.
> There are at least those known solutions:
>    - use > or >> redirection.
>    - use dd(1)
> 
> I have the impression that a home for this feature was searched
> in any tool, and as tee(1) already knew how to write to a file,
> had the "append" feature, and is often used in pipes, it was
> tempting to add it there.
> 
> But looking deeper, --quiet doesn't seem to fit well into 'tee'.
> It even contradicts to the title line in the man page:
>    "read from standard input and write to standard output and files"
> 
> An off-tech argument: ask a local plumber if he'd would ever use
> a tee piece instead of a pipe end piece.  I guess he would only
> if he wouldn't have anything else at hand.

I never knew what 'tee' meant.  That makes sense now.

> 
> A word to the proposed patch: what should happen, if the user does
> not give a file?
>    A | B | tee -q
> The patch just silently ignored that situation which feels wrong.
> 
> Therefore, adding a feature which does not really fit is wrong, and
> contradicts the one-tool-for-one-purpose UNIX philosophy.
> 

Agreed.

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

Tested-by: Alejandro Colomar <alx.manpages@gmail.com>
Reviewed-by: Alejandro Colomar <alx.manpages@gmail.com>

Much better than my patch.  :-)

> 
> Have a nice day,
> Berny
> 

Have a nice day!
Alex


--
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
