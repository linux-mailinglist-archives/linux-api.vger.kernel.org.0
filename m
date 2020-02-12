Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1041D15B207
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBLUm5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 15:42:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43194 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUm5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 15:42:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so3965184edb.10
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 12:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=IgiKGasrvpx5KEqTjK3uSOaiUPZJr6oQaxEeiUKRSC7Mzut+kfrtuMYf7JfgJYo2j9
         r6YHIpl0Oomh/U1TMzjQtQYQDvEFopln06zrn/G9JdYxAN1cr+G4MM7V+yIgIdgHmkT5
         mB2IAKAHrGr3Dq04+09yh6iga9CCs4Dv6Lzfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqyVLATGO6MwZ1NPxpHKDD7nGLBCP8OMxbpMcz0c8xI=;
        b=Mgl3dqaoqjt8jdfI8YI8j7/clRNKApXbGZeXn5TYTx9lPeqcLP7qjFWPiGICBAOES1
         XjN8Zj6kq6nuJ3xkUAHaNf+v/KoLgoalKp3iu7/QDYKTLtLxpANIqWBuTKoC8O4Pj4tW
         YjwwRpQHF4BqL90kUFGMOX7t9gwB9waVBepUvNTq8M9Gxx8UMgFmb0BW9TGj5fqgACFU
         To+AfWDwf1v54FVuEiaclp69160wDuJN4ddHlHnCnrfIYeQEZGlvw3NC0Q/sMa3FX4HS
         7AAJk8zlINhYhwAP0688eHaVZyz5jJJ1wk68pGJfKjKrMu90sKCZ1aO++0ZAebPGvlg5
         AiaQ==
X-Gm-Message-State: APjAAAUJL8UkBvoC3n6mGs1n/1kzF/dqoofP0JfNMpZ3evyV4gM0UBL8
        SFt4pSbONHFCPeNTWLz4aRKoUpPa5qI=
X-Google-Smtp-Source: APXvYqyydH+TkG5SszLrHGiYEEhdpbttbUP/vE3nkHqTH+SYHwDMncKqfXoodcBDz1hRwWCbdElNyA==
X-Received: by 2002:a17:906:3084:: with SMTP id 4mr12586567ejv.140.1581540174706;
        Wed, 12 Feb 2020 12:42:54 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id h16sm3532ejc.89.2020.02.12.12.42.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:42:54 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id z3so4063581wru.3
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 12:42:54 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr9321452ljj.265.1581539720898;
 Wed, 12 Feb 2020 12:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212200335.GO23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 12:35:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Message-ID: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 12:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's to prevent racing with fs shutdown while you are doing the second part?

I was thinking that only the proc_flush_task() code would do this.

And that holds a ref to the vfsmount through upid->ns.

So I wasn't suggesting doing this in general - just splitting up the
implementation of d_invalidate() so that proc_flush_task_mnt() could
delay the complex part to after having traversed the RCU-protected
list.

But hey - I missed this part of the problem originally, so maybe I'm
just missing something else this time. Wouldn't be the first time.

               Linus
