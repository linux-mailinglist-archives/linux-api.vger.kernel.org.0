Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6AF232F5B
	for <lists+linux-api@lfdr.de>; Thu, 30 Jul 2020 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgG3JQl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jul 2020 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgG3JQk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jul 2020 05:16:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0850FC061794;
        Thu, 30 Jul 2020 02:16:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so12443442ejb.4;
        Thu, 30 Jul 2020 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oby0hjKOoKvOjTbMg5/cxe9AIENreOhp+hNmf74/ScA=;
        b=OQYY0Tcrnvzvc7opRBWUyI0Lqkkammr5+WlzI2x2WIPO97RgY7JsMKoJu3EOoPGsDW
         IWuKen6/F5pqE2dKoxDPXDK4MNKqGXUKJYdWqwwTbmkA7hXrF3m5EVUFsnQPxzUgc3Oh
         OXPKTiGzAjPGBmeF9H59Q7PAH5wWYCOBPORAClVdhs/bnNLJwEgV98ph2kydqvgih2i1
         2t5zh14r7WUbQ9DlIF92nfJKbZscjPD1yypy/o3lvNX2+8RDu5VaZHx+uMkrzaxpUnMm
         Jz06rMC538b9EEwighUz+zengTXF1IoCIyogJR11y3j+MJ+zSzFRAbLTHaMErwBjjtgN
         aPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oby0hjKOoKvOjTbMg5/cxe9AIENreOhp+hNmf74/ScA=;
        b=gK0fwljoou7aq6qVNj7y57WxI7TcL5bz5XwGve6IF04QI3D9qcaU/VaQMIGBYVyPnk
         4kdGRfVAxJDsgVBFVpyu1zRdXfIOElMQFNHxjQil+qkp514U9oAr/av2DlaQ88S9Pm6W
         /HJYI2YVM6pzQ7NVmu1GyK8ZFWquR+pCZHLHdg2SZfqzTcuYBL7MPM1sZusmun/0DAdG
         kQ7Bne0mtpeUCOZwflIdCdqBMDfbEjL3kTDA5oPQtQRsRq+wUZUeVJwthZ6dS2v7GUCK
         zdhevSjwtbChdzRPIsAXb/BMnV7Mwf2O6J5oHKLigW0qTPy+QtMoc/vBLOU4AYrH1WTY
         C0rw==
X-Gm-Message-State: AOAM5331pO1+fTO7PVIsSckRqX7LpQB+KxINSUev+nZe7pOu0K49HbLN
        BqZC9sC9qIsxz9xkJwcy24bipZVp
X-Google-Smtp-Source: ABdhPJxf80RJBCTo3YL8pkyfJqP9qfuYLcibUUKSvohy5bHGJzGwJGLinmC4WNeloGHttiX/EMjICA==
X-Received: by 2002:a17:906:68da:: with SMTP id y26mr1646546ejr.250.1596100597384;
        Thu, 30 Jul 2020 02:16:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id w5sm5330591edi.74.2020.07.30.02.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 02:16:36 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for
 pseudoterminals
To:     Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, enh <enh@google.com>,
        Zack Weinberg <zackw@panix.com>
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
 <88273c2f-ce21-db54-688d-5bebd4a81ecd@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cbf7666c-440e-b4bd-0ff6-712123845fae@gmail.com>
Date:   Thu, 30 Jul 2020 11:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88273c2f-ce21-db54-688d-5bebd4a81ecd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Carlos,

Thanks for looking at the patch.

On 7/30/20 6:06 AM, Carlos O'Donell wrote:
> On 7/29/20 6:39 AM, Michael Kerrisk (man-pages) wrote:
>> As per some discussion on libc-alpha [1], many of us are interested in
>> finding a replacement for the problemantic master-slave terminology
>> used in the description of pseudoterminals.
>>
>> Elliot Hughes (enh@) suggested a replacement based on an idea from 
>> an analogous change in the golang libraries, and I've taken a shot 
>> at implementing that idea in a branch [2] of man-pages. The affected
>> pages are:
>>
>>  man2/ioctl_tty.2    | 23 +++++++++++--------
>>  man2/poll.2         |  3 ++-
>>  man3/getpt.3        |  2 +-
>>  man3/grantpt.3      | 17 +++++++-------
>>  man3/openpty.3      | 35 ++++++++++++++++------------
>>  man3/posix_openpt.3 | 10 ++++----
>>  man3/ptsname.3      | 10 ++++----
>>  man3/ttyname.3      |  2 +-
>>  man3/unlockpt.3     | 11 +++++----
>>  man4/pts.4          | 26 ++++++++++++---------
>>  man7/pty.7          | 65 +++++++++++++++++++++++++++-------------------------
>>  11 files changed, 112 insertions(+), 92 deletions(-)
>>
>> Eventually, I think we should take this discussion also to the 
>> mailing list, and also see if we can raise this within the POSIX 
>> committee. But let's see if we can fist off find some terminology
>> that seems agreeable.
>>
>> I've added the full patch below. I am myself still reflecting on 
>> the change. At times, the language feels a little clunky, but overall
>> I don't hate the result. I welcome comments from all, and especially
>> I'd be interested in feedback from Elliot and from Zack, who was 
>> planning to work on this issue in the glibc documentation.
> 
> Overall I agree with Elliott that the changes are positive and make the
> pages clearer. In some case I find the verbosity slightly longer than
> I would want for reading in English. 

I know what you mean. One reason for that verbosity is the need to
clearly distinguish "pseudoterminal device/end" from "pseudoterminal
device pair". It's hard to avoid being wordy there.

> Since I have an EE background I also
> find multiplexer more natural, but I got lost down the "agent noun from
> a verb" rabbit hole and I agree with either position.

I was unsure of which to use. It seems both are used, but some quick 
checking just now shows that "multiplexer" is the rather more
widespread spelling, so I've changed it.

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
