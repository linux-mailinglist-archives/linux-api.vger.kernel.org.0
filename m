Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085C273613
	for <lists+linux-api@lfdr.de>; Wed, 24 Jul 2019 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGXRvA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 13:51:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35962 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfGXRu7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 13:50:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so21318117pfl.3
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=U7Eune/8zAVuopEZ4znflpHQloi7i3WwOpZdcTKXAtw=;
        b=faPCG4Icu73tPWhaSKzXXleFM7v0RLQHzpXK/9FqsRtHV0YhT3JkTFBxhJj2JJxhhB
         R9RCz243EE3JuAt02JRiSSB05PPozCsJKBtgo6U+6x5Z4Cz8ELDXDEHPVWIyVstUlVrA
         htyhbg7aqrxS9yjqRZrRRUwvLxTpYaSz1R0xFM5U+G9K8z5snfQTAwkKU4/W5XGznxqh
         2LHp/0rNA8hgzJa6tU4s/MkGpa9tfC+ze3UvF2seaWqaKRE9eKAODH22jiBmtEgmyht/
         dDU5YoU4GgpMl7YTrQ/6inaURuM79fg23ZHvxyghB109WVgs/oBVk9/ZkhaFhQpReg1G
         CMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=U7Eune/8zAVuopEZ4znflpHQloi7i3WwOpZdcTKXAtw=;
        b=SDloqHqcrJxhLM3a8lwBZUwQ2wdBkMdF2e4Cj/XxunO+2LgWI401skc1wVrnJt4ch/
         dbyE3ZtJs8O3M7YJyWEfyUOrQ3wj4Vj/Koo8LrWj5WHBHrTgK0MLdLFa7G9Yo6q1lMeL
         2XFRZKJ7bSgTlMRUVG+KIXyjWmK91+D2n0zsCdS8/V64x39XxRRb0+t0fEmFEIVlX9ea
         r2AEz4DGMQZqWdaS/Djkw1VkMNo2Qqq3HptqTSeAVB4dX8w8lGqH6QV1pTFWOvgsevVr
         xT9D8HCBaVglXT4Lghc986aOAgoaVO6j9kAQs4O49o2rIYCHfCPuyVhebHF0OpO763uV
         61UQ==
X-Gm-Message-State: APjAAAWzQWhhGlB4gaXAmKBvEXR7xESLv1S2vKsDVL39ao4235XEi2H3
        +Ri02mpxYBgzEWsbjs8Olps=
X-Google-Smtp-Source: APXvYqxYg1bPHXo/qNgG9lWQv3PEC9/yMJxShLI9EEzdd+wYcoYvNKFNT8Z6ZwfJZpGtXPRFW4Z6jQ==
X-Received: by 2002:a63:5945:: with SMTP id j5mr82124622pgm.452.1563990658681;
        Wed, 24 Jul 2019 10:50:58 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id i6sm50042071pgi.40.2019.07.24.10.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:50:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:50:49 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io> <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
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
Message-ID: <95CD0533-576F-4B3A-8E80-D3D89967EE2C@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On July 24, 2019 7:45:38 PM GMT+02:00, Linus Torvalds <torvalds@linux-found=
ation=2Eorg> wrote:
>On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> This adds the pidfd_wait() syscall=2E
>
>I despise this patch=2E
>
>Why can't this just be a new P_PIDFD flag, and then use
>"waitid(P_PIDFD, pidfd, =2E=2E=2E);"
>
>Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
>takes an argument of type pid_t, but it's the same type in the end,
>and it does seem like the whole *point* of "waitid()" is that
>"idtype_t idtype" which tells you what kind of ID you're passing it=2E
>
>               Linus

Well in that case we could add P_PIDFD=2E
But then I would like to _only_ enable it for waitid()=2E How's that sound=
?

Christian
