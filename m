Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6777D0CDE
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 12:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJIKcZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 06:32:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKcZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Oct 2019 06:32:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so2201368wrj.6;
        Wed, 09 Oct 2019 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BQ4ZDj2JG2Tmsvr++5KOPO49CW/5dxWvwlyViQLHhsk=;
        b=HODhBtWKpeZDll66MpMafHpE9IWR4D6ja8jUy2WG7N0ge2GZGnc2uJNJmfn1/MMfy4
         2enTv+1pnzR5bW6E6FOjo4EYUfqKWjZXnx3fJqwHGZ4wwY5YSju1L0AAVUwdhC/KCL5D
         IZm8ha+7UEh4MYrrGOpqd2X8T1wQudWEruArisyAMLMtAqJ0WGTqZhS9yeyIO//Dkpql
         QuX0c0dqMCzK7u9WfD3P3wZ0uXIGtb6LF4zI9yI4PhwH+3rfM+0Q334InnS8HfaaDcPs
         ssgvX5MoPCB3fEwltdlFg1kaVUOAeHQMDv4ClApgC9y09S3dIDOwIVDPm8IhHsuoo/Wj
         EoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQ4ZDj2JG2Tmsvr++5KOPO49CW/5dxWvwlyViQLHhsk=;
        b=gZLsHITsScO4WIwKCApQSeKUFbrg4SaOzD6VgTWsUplDAqvirBOaNSLHCQrnigPze4
         HiwUcNmzQIMaHJCY94dNmJ8469d4JLwf5WfRuz/5CRfNjFATpGAnSCo4J3NoY4CC9VLC
         2m20OhRUDbjGNnTt1nJ0lYtUn8hr8KorBmIyws7M3cax0E12ecAbB8pmMVQNx44H4il2
         MoG6i05vOzNoIUJxDGHbEI7vsSdad6q15+g82dBeSvCN2KdBtYMZ4jObOZLztbHWGcNC
         6t4KYpqjfJYQmoEiKMA7z2/W2BP6wmV+yCS7fbv6U+IUg6NwwlCgWkZBhnJaxR2WNz3g
         ydJQ==
X-Gm-Message-State: APjAAAW+6vYM6QE3gLbOO/tbgFzvPkqHEO42zZREiS/bH0Y4DYmMp7/J
        RREm1wEEoqIxMlf17UVGPGRjrNGq
X-Google-Smtp-Source: APXvYqwRrYU8mvy1Od3txRnjM4K2axiZYa01hE86x0NDTo/h4cACP/xgoSdjmQQOUZ/3oGcioOB9ow==
X-Received: by 2002:a5d:6984:: with SMTP id g4mr2274573wru.43.1570617140559;
        Wed, 09 Oct 2019 03:32:20 -0700 (PDT)
Received: from [10.0.20.253] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id i11sm1845628wrq.48.2019.10.09.03.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:32:19 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] openat2.2: document new openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <20191003145542.17490-1-cyphar@cyphar.com>
 <20191003145542.17490-4-cyphar@cyphar.com>
 <b52e4a93-a3de-dcbf-3684-bb2c355f3f24@gmail.com>
 <20191009101733.kgbg2aekjguykddu@yavin>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3bc4295a-45c3-53d4-a10a-44c56018f151@gmail.com>
Date:   Wed, 9 Oct 2019 12:32:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191009101733.kgbg2aekjguykddu@yavin>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Aleksa,

On 10/9/19 12:17 PM, Aleksa Sarai wrote:
> On 2019-10-09, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>> Hello Aleksa,
>>
>> Thanks for this. It's a great piece of documentation work!
>>
>> I would prefer the path_resolution(7) piece as a separate patch.
> 
> Thanks, and will do.
> 
>> On 10/3/19 4:55 PM, Aleksa Sarai wrote:
>>> Rather than trying to merge the new syscall documentation into open.2
>>> (which would probably result in the man-page being incomprehensible),
>>> instead the new syscall gets its own dedicated page with links between
>>> open(2) and openat2(2) to avoid duplicating information such as the list
>>> of O_* flags or common errors.
>>
>> Yes, looking at the size of the proposed openat2(2) page,
>> this seems best.
>>>
>>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>>> ---

[...]

>>> diff --git a/man2/openat2.2 b/man2/openat2.2
>>> new file mode 100644
>>> index 000000000000..c43c76046243
>>> --- /dev/null
>>> +++ b/man2/openat2.2

[...]

>>> +.TP
>>> +.B RESOLVE_NO_SYMLINKS
>>> +Disallow all symlink resolution during path resolution. If the trailing
>>
>> Disallow resolution of symbolic links during path resolution
>>
>>> +component is a symlink, and
>>
>> symbolic link (throughout the page)
>>
>>> +.I flags
>>> +contains both
>>> +.BR O_PATH " and " O_NOFOLLOW ","
>>> +then an
>>> +.B O_PATH
>>> +file descriptor referencing the symlink will be returned. This option implies
>>> +.BR RESOLVE_NO_MAGICLINKS .
>>> +
>>> +Users of this flag are encouraged to make its use configurable (unless it is
>>> +used for a specific security purpose), as symlinks are very widely used by
>>> +end-users and thus enabling this flag globally may result in spurious errors on
>>> +some systems.
>>
>> It's not really clear what you mean by "enabling this flag globally".
>> Could you reword, or explain in a bit more detail?
> 
> A better word might be "indiscriminately" -- the point being that if
> a program uses it for every openat2() call (and users cannot disable
> it), then the program will break on all sorts of systems.

Okay -- could you please amend the text to say something more like what
you just clarified.

> 
>>> +.TP
>>> +.B RESOLVE_NO_MAGICLINKS
>>> +Disallow all magic-link resolution during path resolution. If the trailing
>>> +component is a magic-link, and
>>> +.I flags
>>> +contains both
>>> +.BR O_PATH " and " O_NOFOLLOW ","
>>> +then an
>>> +.B O_PATH
>>> +file descriptor referencing the magic-link will be returned.
>>> +
>>> +Magic-links are symlink-like objects that are most notably found in
>>> +.BR proc (5)
>>> +(examples include
>>> +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
>>> +Due to the potential danger of unknowingly opening these magic-links, it may be
>>> +preferable for users to disable their resolution entirely (see
>>> +.BR symlink (7)
>>> +for more details.)
>>> +.TP
>>> +.B RESOLVE_BENEATH
>>> +Do not permit the path resolution to succeed if any component of the resolution
>>> +is not a descendant of the directory indicated by
>>> +.IR dirfd .
>>> +This results in absolute symlinks (and absolute values of
>>> +.IR pathname )
>>> +to be rejected. Magic-link resolution is also not permitted.
>>
>> So, this flag implies RESOLVE_NO_MAGICLINKS? If yes,
>> it would be good to state that more explicitly,
> 
> It does, though this might change in the future (some magic-link
> resolutions might be safe -- but it's unclear what the semantics should
> be). Users should explicitly set RESOLVE_NO_MAGICLINKS if they really
> don't want to resolve them.

Okay -- I understand. Perhaps you could then at least say something like:

Currently, this flag also disable magic-link resolution. However, this
may change in the future. The caller should explicitly specify
RESOLVE_NO_MAGICLINKS to ensure that magic links are not resolved.

>>> +
>>> +.TP
>>> +.B RESOLVE_IN_ROOT
>>> +Temporarily treat
>>> +.I dirfd
>>> +as the root of the filesystem (as though the user called
>>
>> Perhaps better:
>>
>> Treat
>> .I dirfd
>> as the root directory while resolving
>> .I pathname
>> (as though...)
> 
> Yeah that sounds better.
> 
>>> +.BR chroot (2)
>>> +with
>>> +.IR dirfd
>>> +as the argument.) Absolute symlinks and ".." path components will be scoped to
>>> +.IR dirfd . Magic-link resolution is also not permitted.
>>
>> Insert a newline before "Magic" to fix a formatting problem.
>>
>> So, this flag implies RESOLVE_NO_MAGICLINKS? If yes,
>> it would be good to state that more explicitly,
> 
> Same reply as above.

See above :-)

[...]

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
