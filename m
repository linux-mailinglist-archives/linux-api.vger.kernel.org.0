Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E660A19D0B2
	for <lists+linux-api@lfdr.de>; Fri,  3 Apr 2020 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbgDCHCT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Apr 2020 03:02:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33336 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389177AbgDCHCT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Apr 2020 03:02:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so7235239wrd.0;
        Fri, 03 Apr 2020 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xiz/6HJMasAWNsKkYKq00dnOIXVpiuKViHO1DMPX3Zg=;
        b=GUkPwzaJIqHf6RLgEXskzpsmx8udxuWbTIFUXOf9bF2pzOH11b2HHNaputhdeJ5i7p
         +iPA3GVGkxsOtqiq53YFKQGPx6o2WzkEhVL4r/sISxYuwkBFgXJOXEDhmZwftpNL9yQV
         aYCag7PWTpXlyTI6KMEicP/P+6IdIRMNBIKF5jviP5f/uCJ6dYrnxQKMb39kufjPCs3S
         J0TzbJi/UE5HfpXjxdjb6LO9QuZw+o5RkzsMZTzWU242tP5b462BnD/lsS45+ICj0yUs
         FJPFeu4tG7JseBle5/OhnFS8BCLIgOZ71Hf1B5EI1WgeSJJG/tcmwk3MEpvCE2vOny9G
         A36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xiz/6HJMasAWNsKkYKq00dnOIXVpiuKViHO1DMPX3Zg=;
        b=PUEIYyCO+FVjRm9jpjBZjYig/vO41MVOX/s+qtMFTGtjCYakImdYhWsZDJK9imzNzL
         F1LLokOfqv/VqKxbXdtHjr1E2ti3xXi9v9qlwzPZ+6K3kkYozrSGAb0cHyb7drzenf5Z
         QYT4XzTxriDhk9pdFL6ZXMX21yEBFp7NF8ioLFchoZ/VELQrk4Z7Ui7m/2gqo7JguXa9
         2Q2EUezPSZC8j7UTfl+2j69N99ZhRNSRs3BqdqQ3XPqemKtv6Mhyyk0ZRGf3ktZscpfx
         ePt2+jkw5Jv1EeUhnN9Ufg92hY502yL5bXfEKJQP6TMfis4DjLwNo26aVsrQzuWRs0aI
         RZnw==
X-Gm-Message-State: AGi0PuZf4OD8IkFG1dFU5nKq7wXImMBFEzR69pDtX1iB/kuFKIQhb+rd
        qN1JLYymqin3is8+o3JXCvKyJU0P
X-Google-Smtp-Source: APiQypKCPcCG7/fjGTqNwVkfSBThYJqHxqbDbQXpZiEg8ahhjpuyZtJIuyh/EVNowqC2sJ2Rgye56w==
X-Received: by 2002:adf:aacf:: with SMTP id i15mr7112366wrc.31.1585897335219;
        Fri, 03 Apr 2020 00:02:15 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id d13sm11153452wrq.11.2020.04.03.00.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 00:02:14 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     Eric Rannaud <eric.rannaud@gmail.com>
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
 <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
 <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com>
 <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cb4c685b-6c5d-9c16-aade-0c95e57de4b9@gmail.com>
Date:   Fri, 3 Apr 2020 09:02:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hell Éric

On 4/2/20 10:49 PM, Eric Rannaud wrote:
> On Thu, Apr 2, 2020 at 1:19 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>> There is documentation in:
>>> - include/linux/posix-clock.h
>>> - Documentation/driver-api/ptp.rst (explicitly states that EOPNOTSUPP
>>> should be returned)
>>
>> (Is this a reference to the tack that I tweaked your patch to change
>> EOPNOTSUPP to ENOTSUP?)
> 
> Oh not at all, I hadn't noticed your patch. I just wrote that sentence
> to point to ptp.rst as a spec of sorts for that particular behavior
> addressed by this patch.
> 
> I never know which one to use of EOPNOTSUPP or ENOTSUP since they have
> the same value (in userspace) but POSIX.1 says they shouldn't.
 
I think you are looking at an older version of POSIX (when what you 
say was true). In the POSIX.1-2008/SUSv4 specification of <errno.h>, 
we have:
[[
[ENOTSUP] Not supported (may be the same value as [EOPNOTSUPP]).
EOPNOTSUPP] Operation not supported on socket (may be the same value as
[ENOTSUP]).
]]

> suppose for man2 it makes sense to pick one, whereas man3p has to make
> the distinction.

It's a mess of course. It looks like the usual reason: BSD vs
other historical implementations. BSD invented EOPNOTSUPP for
the sockets API (and you see this reflected in POSIX.1). Other
implementations (presumably System V) had ENOTSUP (which
is what appears in POSIX.1 for timer_create() and
clock_nanosleep()).

> For what it's worth, man2/ has 29 mentions of EOPNOTSUPP (value of 95
> on x86) and 8 mentions of ENOTSUP (with a value 524).

> In the kernel sources, it's 6324 vs 1512. But note that in kernel
> code, EOPNOTSUPP has a value of 95 (on x86 anyway, it is arch
> dependent), whereas ENOTSUP is 524. Glibc is the one that defines
> ENOTSUP to EOPNOTSUPP.

Actually, there are 0 mentions of ENOTSUP in the kernel
(other than in tools and samples). The constant that appears
in the kernel is one called ENOTSUPP (2 P's) defined as 524 
in include/linux/errno.h !! Yikes! What a mess!

And then EOPNOTSUPP defined with value 95 in the kernel file
include/uapi/asm-generic/errno.h (and with some architecture
variations as you note).

And then in glibc sysdeps/unix/sysv/linux/bits/errno.h:

[[
/* Older Linux headers do not define these constants.  */
# ifndef ENOTSUP
#  define ENOTSUP               EOPNOTSUPP
# endif
]]

And in glibc EOPNOTSUPP is 95

> So if we had to pick one for man2/ (and man7), I'd argue for
> EOPNOTSUPP, for consistency with kernel code, now that I look at it in
> more details.

I'm not sure we do need to pick one here. See POSIX, which uses
both. 

And see the definition of EOPNOTSUPP in POSIX. Arguably,
it is only for sockets, and everything else should be ENOTSUP.
(And for the most part, that's how things are done in the 
POSIX specifications of the APIs.)

In summary, I'm going to do nothing :-}. I checked
* the time/clock man pages; they use ENOTSUP (consistent with 
  POSIX)
* the pthreads man pages; they use ENOTSUP (consistent with POSIX)
* the sockets APIs man pages; they use EOPNOTSUPP (consistent 
  with POSIX)

The rest of the pages are a mixed bag (mostly not specified in
POSIX), and I don;t think there's any really clear fix.

>>> - include/uapi/linux/ptp_clock.h
>>
>> ... it's a bit of a stretch to call any of those documentation, since
>> they don't really describe the concept of a dynamic POSIX clock
>> device.
>>
>>>
>>> (IEEE 1588 PTP is the canonical user of these dynamic clock devices)
>>>
>>> Would you want to refer to any of these from the man page?
>>
>> See above. I would be happy to add a 2 or 3 sentence note to the page
>> that briefly describes the concept of a POSIX clock. Would you be able
>> to come up with something?
> 
> I'll try, but I've never used them, so I'm not convinced I can capture
> the concept clearly.

Its okay -- don't feel any obligation here. You already contributed!

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
