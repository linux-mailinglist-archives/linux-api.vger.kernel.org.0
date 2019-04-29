Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C42EB8B
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfD2UV1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 16:21:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UV0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 16:21:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id d12so9025479lfk.6
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KBkvUzTALKgFLj/TOeD9d/FpBJiRxV8AwPVY9LOciU=;
        b=OxXZEkxbYVzsZQ7Cy5ZsCi/u7kILgUKY0trvo9FOK+C+EkZRHqW8ZFkNORrDIB/mqL
         F/DSCTJh2z/j8+NKw8b00XyqeE7sxk5+H0Bxooo63jGIVK8qknkJLbfkGup5Jj50YRvg
         NW6+HnkqAnsclagMIbZlDrPBCOOSVVvs2zEnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KBkvUzTALKgFLj/TOeD9d/FpBJiRxV8AwPVY9LOciU=;
        b=Difr/4RHieL7kqj9CidZtfqioSd2YGXvwTGSCddEWNusXWuQp3CRDSLGgkWR80e4ZY
         DeSSd5H2qIJffqDOUjCB3qUgmrGzb21Sq1dI9C0FqonQfvgwEqP689VlF5+VHbdNt01X
         MsMsMLXkMOD1uqfSKy3vxF0zJqAoqcjaMe/eM+bGF+7HFJrggasuR0UwwpnuZThZqQiJ
         XzjJUc8Fdx5pTVnKa0Bs2E1B7dFsaR8l4HDNC75nOAMVV4zE5o65TXs4sGehAdyMgap3
         rV0lF1OuGeKSkluYBN6IakghXQXAC8itvQUn9eVQMYRmYxHSbNBUk3K8ZKvVeFhTVaZm
         FXcg==
X-Gm-Message-State: APjAAAWNMeBnRmpcG2oUtKJmrsx1ZKw1mYi3m7ErYhx3GKtvqvGtI+wQ
        g50t8/WZ3DJOpdI9LTJQqIQ2rP8m0GA=
X-Google-Smtp-Source: APXvYqxan86UPmwCH9WajznXCeFR0XXCkmUs3SHB8VnaMy+Bkp+LlvJbuyNfRzDjnI3R2VxlcM4jSg==
X-Received: by 2002:a19:ca02:: with SMTP id a2mr33027498lfg.88.1556569284450;
        Mon, 29 Apr 2019 13:21:24 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o24sm4725190lfd.42.2019.04.29.13.21.23
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:21:23 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id v1so9034694lfg.5
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 13:21:23 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr34223361lfm.166.1556569282855;
 Mon, 29 Apr 2019 13:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
In-Reply-To: <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:21:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
Message-ID: <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Jann Horn <jannh@google.com>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 12:55 PM Jann Horn <jannh@google.com> wrote:
>
> ... I guess that already has a name, and it's called vfork(). (Well,
> except that the Linux vfork() isn't a real vfork().)

What?

Linux vfork() is very much a real vfork(). What do you mean?

                 Linus
