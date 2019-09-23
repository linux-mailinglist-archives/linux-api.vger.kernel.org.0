Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13C8BBCBF
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 22:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfIWUW1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 16:22:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34644 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUW1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 16:22:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so46552wmc.1;
        Mon, 23 Sep 2019 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sABo8fLMmTTmo2WcsGn2dlPsS9QgOD70KLdhw5rDeGk=;
        b=JekV9Lb2cMDaSOrgeBz8Tn9/0nx6HQ6EVSgTz/JQ8h7n5jlEXZevyQVgO/LRuqyiGl
         LmfXXexf/2f/Wh1RnH1/JX3/lL4lMdUuh0PZ7+Byh2TTyk5Hrp90LcHtlVW2iPI29/2P
         Yeie3y6t/iZGO3hIvelLPRGUPMZ/MG27pt1fK7UvI8+2QL75w4IBfVfWL2ZtIzjOKSDy
         KWC6qhsxMndz0dm3yunmJns07e5qNiV/ONwHtq3K95GmMPy27awR8p0ioxArtrQb5T8e
         ZKFfFHoKr4LYqsIb54AmzuKD7GXsCV+f8VBu169S5J2SwbvYdjKaYbLMTU8bzmSXWGn5
         pBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sABo8fLMmTTmo2WcsGn2dlPsS9QgOD70KLdhw5rDeGk=;
        b=srZfMKkBK36bNjCEHv/jIDHzXJecrFvBSa5fRY41xRwwGFzOAhUkROUPZTvkgUSaN2
         uubQ7GqEn3qvm0blSP6tFEtO8NEAuaeoBwxWNR0+ak+J0e64rAoPsXuSjFLNwXXE7FXZ
         7u2aYpchO3voYSG4yJ2k5+t7JTzvWp8HS60gC7PIhiwNrjG6064GhHLGTyQRXTLFdQDu
         +/Mig2/aODdCgKmUN2iBvkaDdgWJA4dUii4F9hEiQj7dKlJko2cdHE7U2f1TAdoete/R
         t0xkfojVKuquGrTNwzSZZtWiJ4rScG9aHl95ghCDZN2eME2sroyNGN7hmYkVGjYFfkKU
         NO7g==
X-Gm-Message-State: APjAAAVjPD+MvrfwrMeGrl/Q2ZHjeYkbc1NjV8LXbRALMxz3s95fl4eR
        nlFoMADUwlpAsSLVkssWtQE=
X-Google-Smtp-Source: APXvYqz48BF1OX5tCIYtwrl2pglXhd4mgeM4GQHOc01MiZ8dCkcAlC5rWIPKpoQkfzJ70dhv+/CSQA==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr950909wml.86.1569270143968;
        Mon, 23 Sep 2019 13:22:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:243d:bf01:c49e:ef23:e680:96b1? ([2001:a61:243d:bf01:c49e:ef23:e680:96b1])
        by smtp.gmail.com with ESMTPSA id g185sm23169800wme.10.2019.09.23.13.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:22:23 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: For review: pidfd_open(2) manual page
To:     Daniel Colascione <dancol@google.com>,
        Florian Weimer <fw@deneb.enyo.de>
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
 <87tv939td6.fsf@mid.deneb.enyo.de>
 <CAKOZuetTgKjgWZpCaBz8q662MwVQ-UhrV4oWFqKEWr35mQTFLw@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <39790bc7-f417-1172-0f06-5cdefabda7e1@gmail.com>
Date:   Mon, 23 Sep 2019 22:22:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuetTgKjgWZpCaBz8q662MwVQ-UhrV4oWFqKEWr35mQTFLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Daniel,

Than you for reviewing the page!

On 9/23/19 1:26 PM, Daniel Colascione wrote:
> On Mon, Sep 23, 2019 at 3:53 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>>
>> * Michael Kerrisk:
>>
>>> SYNOPSIS
>>>        int pidfd_open(pid_t pid, unsigned int flags);
>>
>> Should this mention <sys/types.h> for pid_t?
>>
>>> ERRORS
>>>        EINVAL flags is not 0.
>>>
>>>        EINVAL pid is not valid.
>>>
>>>        ESRCH  The process specified by pid does not exist.
>>
>> Presumably, EMFILE and ENFILE are also possible errors, and so is
>> ENOMEM.
>>
>>>        A  PID  file descriptor can be monitored using poll(2), select(2),
>>>        and epoll(7).  When the process that it refers to terminates,  the
>>>        file descriptor indicates as readable.
> 
> The phrase "becomes readable" is simpler than "indicates as readable"
> and conveys the same meaning. I agree with Florian's comment on this
> point below.

See my reply to Florian. (I did change the text here.)

>>> Note, however, that in the
>>>        current implementation, nothing can be read from the file descrip‐
>>>        tor.
>>
>> “is indicated as readable” or “becomes readable”?  Will reading block?
>>
>>>        The  pidfd_open()  system call is the preferred way of obtaining a
>>>        PID file descriptor.  The alternative is to obtain a file descrip‐
>>>        tor by opening a /proc/[pid] directory.  However, the latter tech‐
>>>        nique is possible only if the proc(5) file system is mounted; fur‐
>>>        thermore,  the  file  descriptor  obtained in this way is not pol‐
>>>        lable.
> 
> Referring to procfs directory FDs as pidfds will probably confuse
> people. I'd just omit this paragraph.

See my reply to Christian (and feel free to argue the point, please).
So far, I have made no change here.

>> One question is whether the glibc wrapper should fall back back to the
>> /proc subdirectory if it is not available.  Probably not.
> 
> I'd prefer that glibc not provide this kind of fallback.
> posix_fallocate-style emulation is, IMHO, too surprising.

Agreed.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
