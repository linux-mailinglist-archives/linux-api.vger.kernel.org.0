Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC217361E
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfGXRwR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 13:52:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfGXRwR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 13:52:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so21578767pgv.10
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=LTjRTgv0sSmtdgDvRAyQuDy9Soq0qaA8z85xb1R02ko=;
        b=LVjyjijHQHfKDB6TTxxNkMKbqO6LZ3oZ9xr6a+Lk5e9HTmzvFnjYdxJpij+ZfGWRwO
         Zw2lmgqEgTRRQotlMWUsu3n2j2Vq3MVfj+Ghb4xfgNigDe4VfBSvM+699iujfFLG4hfQ
         1Bz2Uqco9uS3hLa+qE7rWLO8OSXOsa8pfHZFvlD5+Z6+S47ULGO+utVcPZLVMc0Khg5A
         B3Vvp3vvJnhGHCPrH7wPWhgWtdjZpMRSsK9KG5AsOEbsr63+Ra2ww8viC308puOrXrC8
         ft8fq94RETHXmbkgAvaWy5REviRNtrsFGY3WStZNOi8HuaUP+RZnWui5qA1QdSKayO+j
         tbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=LTjRTgv0sSmtdgDvRAyQuDy9Soq0qaA8z85xb1R02ko=;
        b=lssV+HivpklKQVJmNL3iYPp76agvt2NfAhMiyDhIeDjXI6Ewun3J8I97oSUV5YNDXq
         a5ffsSO9Jx4VgBxJEI2rcMs6NXzg1jMntWI2h7Lm1gUeTpZ8HlaSWi7Ep5b2wORh4+vu
         J+aippdE90EVZAcGZbz8EuKy9W/xueUtsfmWJvjttke459qUU7IenSzcX8N9jevZE9Ju
         m+VfT3io288jvwKs38XGi+o0TQYmWdoGnjwjlLfRllp+tvsGPSI76D3sXbJKx86ezJFq
         wsxCDKXUNJPiwIR538zRGH5/DYRWBfbCQCekQsm20xdbhysPggymGG1vytA6UN+tNFjp
         sOQw==
X-Gm-Message-State: APjAAAV/uWddPjq9f7pvMlGBYjiNSZaZSRvVNV0Ix6pSUTaotfQFrqb3
        MeJWKXnHxyRzWIl3XKgeZ2razRqpUF4=
X-Google-Smtp-Source: APXvYqx7+JaUSwr8oNVFzhmI++HcH6nim4+KpKUYTgfT7PR5Hc6bp0HuElxuSpi3e2JwPJevG2BIaQ==
X-Received: by 2002:a17:90a:6546:: with SMTP id f6mr42634439pjs.11.1563990736774;
        Wed, 24 Jul 2019 10:52:16 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g2sm78654497pfq.88.2019.07.24.10.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:52:16 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:52:08 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <95CD0533-576F-4B3A-8E80-D3D89967EE2C@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io> <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com> <95CD0533-576F-4B3A-8E80-D3D89967EE2C@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <D9BD06E2-576A-4627-8047-0AA86B6CCDA9@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On July 24, 2019 7:50:49 PM GMT+02:00, Christian Brauner <christian@brauner=
=2Eio> wrote:
>On July 24, 2019 7:45:38 PM GMT+02:00, Linus Torvalds
><torvalds@linux-foundation=2Eorg> wrote:
>>On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner
>><christian@brauner=2Eio> wrote:
>>>
>>> This adds the pidfd_wait() syscall=2E
>>
>>I despise this patch=2E
>>
>>Why can't this just be a new P_PIDFD flag, and then use
>>"waitid(P_PIDFD, pidfd, =2E=2E=2E);"
>>
>>Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
>>takes an argument of type pid_t, but it's the same type in the end,
>>and it does seem like the whole *point* of "waitid()" is that
>>"idtype_t idtype" which tells you what kind of ID you're passing it=2E
>>
>>               Linus
>
>Well in that case we could add P_PIDFD=2E
>But then I would like to _only_ enable it for waitid()=2E How's that
>sound?
>
>Christian

Ah, sorry, just saw that that's what you suggested=2E

Christian
