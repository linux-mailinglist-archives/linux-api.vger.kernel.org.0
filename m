Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693FB23407A
	for <lists+linux-api@lfdr.de>; Fri, 31 Jul 2020 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgGaHsl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 Jul 2020 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbgGaHsk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 Jul 2020 03:48:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032CC061574;
        Fri, 31 Jul 2020 00:48:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id df16so5400929edb.9;
        Fri, 31 Jul 2020 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ftTOVOCixhKxxVlnoh0i484JW3e9En7DFxByS6V+7po=;
        b=VIXwcf7oexztSDGRAyJovbMHUal4H1k8VBNQU394jT2EX7xvuJSSI4Z0IrjSTGWTZ3
         mE1HIgf9grNHi27/0jIru1WHxRReP2beCGdflFl/zKrMRZ1DkcoYuXYGxC/JcBYGuA21
         tPRStoXZkRbMpzZmwzEFwFrDLpNt2g5HwQmyf5q2QNMTKF6PkqE+cb17KWBtbOcA8Lii
         w0m+DK2OABtJgaPKedafOg2BLNy8FFX8mfivYX1kZVU1SuCcoKXkFSy+a4Hedikq7whN
         xq09DIDdUQz8tSMDDbNixpuarkh7wXYcDtdsrLFMkJilK+U3c4NyHBmzSQSNUztmxmYJ
         aPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ftTOVOCixhKxxVlnoh0i484JW3e9En7DFxByS6V+7po=;
        b=IZ1VI9u7FmlbY08bcLnEkrv4mNrQvlh0/BSqh42jVynPmAMElr8yBii8D/h+Kbcw1Q
         s5GoQyf+7nEK7T76/R1J1btODR669BRIUA60cwHRV9V7z2ysKGWdsm1DWF7axZsN8lUS
         ZaYa3rY7QDk0pvpYvSE1Bw3vivLJh2NaJjIjfDjupTAbi8sjGDvAWp5ebFJtVNhGaDI/
         +ATOqhB9T5RRNvIZYB/NRVVdOE2QrKy8tb3me9qYw4BG5nCH2ac26mu2yCukmRr0SYAW
         1yXn+OdPuZL7M0KR/10xtQrKTqBRmjtg4CkKTjyaYedOm4N2+RbGlYlheOF7BKXlYdtG
         4twQ==
X-Gm-Message-State: AOAM533s3dAz49ZhK8TQhjRiQpMDKwsWmOelVoOQ9m8H3VjZYnXCtyp2
        txvm94TuXN+F+tdL3JsJH5xNj0rA
X-Google-Smtp-Source: ABdhPJzdgwlYpBgOWDfNAIT9gNyzVgmBfZzVkBgnvFp6cs2Hv2h+mkuqTHc0jdnNZ7Q2TJJamvS4/w==
X-Received: by 2002:a50:8305:: with SMTP id 5mr2754718edh.174.1596181718662;
        Fri, 31 Jul 2020 00:48:38 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id ce12sm9076977edb.4.2020.07.31.00.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:48:37 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for
 pseudoterminals
To:     enh <enh@google.com>, Carlos O'Donell <carlos@redhat.com>
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
 <88273c2f-ce21-db54-688d-5bebd4a81ecd@redhat.com>
 <cbf7666c-440e-b4bd-0ff6-712123845fae@gmail.com>
 <c690ad2f-5f3c-5a8b-7b4c-ad29976aeab0@redhat.com>
 <CAJgzZoqR4Vh0phZjrDB9dgxNPzH0a35YjC1CwKb3mREOFn5Kbg@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c756202e-7af8-c1b4-e99f-d77f3eae8c09@gmail.com>
Date:   Fri, 31 Jul 2020 09:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJgzZoqR4Vh0phZjrDB9dgxNPzH0a35YjC1CwKb3mREOFn5Kbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Elliot,

On 7/30/20 10:35 PM, enh wrote:
> On Thu, Jul 30, 2020 at 4:38 AM Carlos O'Donell <carlos@redhat.com> wrote:
>>
>> On 7/30/20 5:16 AM, Michael Kerrisk (man-pages) wrote:
>>> I know what you mean. One reason for that verbosity is the need to
>>> clearly distinguish "pseudoterminal device/end" from "pseudoterminal
>>> device pair". It's hard to avoid being wordy there.
>>
>> The perfect is the enemy of the good. My feeling is that as others
>> write this text in emails or discussions, we'll eventually all settle
>> on some other short form we find agreeable and then later we can adjust
>> the man pages to use that.
> 
> based on my own brief experience, i'm expecting that _code_ will
> settle on pty and tty. but if you're reading the man pages to
> understand the concepts -- which are inherently quite confusing -- i
> think spelling things out in longhand might remain useful in that
> context.
> 
>> Until then taking the lead to change this
>> language is the correct way forward.
> 
> yeah, definitely.
> 
> i'd prefer for michael to go first -- since the bionic documentation
> is basically just a link to man7.org, and even without that he's the
> canonical source -- but i'm happy to go first and submit my change
> first if it helps us make progress :-)

I'd prefer to take this a little slowly. I don't plan to merge the
changes just yet. I'm interested to get a bit more feedback first,
including from Zack. (I'm guessing Zack is on holiday or so, which 
is why we've not heard from him.) Also, if we have rough consensus
on this change, I would like to raise it with the POSIX folk; it
would of course be great if there was a corresponding change in the
standard, so that we all (all UNIX) have a common set of reference
terms.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
