Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54496754B9
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfGYQ5B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 12:57:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36705 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfGYQ5B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 12:57:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so51611295wrs.3
        for <linux-api@vger.kernel.org>; Thu, 25 Jul 2019 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLks1VEJfg9MJoVbv9YekdEVNfnWrN4IEBUkUatWcHY=;
        b=QaNQQpH5AQEF+zjkRSPqqyzmm0k2dKJifTpV9RujHZdBYmvv3OT0jRioUwm7mnk0N+
         ursxEFRjypSDdnVYK5PsaEleTbvjIrQx8OsG1RwFl9BKEUJiNGpa00fa0ZriSzFYotyz
         IBPL1R4T7BNOdgJHJNpAet8Jm0rLaN6BxH9uLXHHL2bIktLlMj72SdbCOeH8H2qJeBBO
         Csg2Uh1ojBLSTcGVi7lkZ333WsRdmY8txb1YPIZMvk0tVbNR0S/AJlRodKip7T5Thlp3
         GxNzr/sM2la7Rr2khnryUfM5fj3nVbpMKgrFry55KoSUbYrtMj0bOorZ1laWvikjtOq6
         G7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLks1VEJfg9MJoVbv9YekdEVNfnWrN4IEBUkUatWcHY=;
        b=W4gxhKSgGO8LdfKz8LUZwK5J2BE6moGyY5mX9Sp8dZ6lltP7IIvMVCfA9EHBQ31tmB
         sLJZD5xe0djQmV5O6/KqBuC+zt0N0V15Mm1MzKesIewJvCM49GH38h96P2e7aitEI007
         VYaoIG9pExyCfPE1O0CHv29YpTiFvmUsnU4h+ECKrAwWGr2MbV9HBAn3eB+Oq+PzVi58
         MfylVJJTaYBq8RRZrTP+0Q0xm2QKghsNGdF3DXwLIGSNcZevgLn+ExABoIV09wlPLu4S
         KOh/lNb5iXxAkX/ZL6aWPUe+wr6vEkGHKtXatQcqKITFXSSc61dBwSlEnCoH6TM4GsmF
         /o4w==
X-Gm-Message-State: APjAAAW6xOXYFiARoR5Qcy5flKoklSJyDy/kJmutEdQcByEGZJsPWTrG
        dJdorLJwd2WuPXBE3KfY5M4=
X-Google-Smtp-Source: APXvYqxHOSCEMiZxmJzM/sQ53v5RVi//yFTL5semXNJz37Qx/2Nv24/f1YfyUPzHtH9RtHdoP4OX5Q==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr41450933wrp.202.1564073818896;
        Thu, 25 Jul 2019 09:56:58 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id z7sm47723214wrh.67.2019.07.25.09.56.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 09:56:58 -0700 (PDT)
Date:   Thu, 25 Jul 2019 18:56:57 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725165656.pbtmtm3hxxmj4aq6@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
 <20190725112503.GG4707@redhat.com>
 <20190725114359.GH4707@redhat.com>
 <20190725122650.4i3arct5rpchqmyt@brauner.io>
 <20190725161316.GI4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725161316.GI4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 25, 2019 at 06:13:17PM +0200, Oleg Nesterov wrote:
> On 07/25, Christian Brauner wrote:
> >
> > The key is that you want to be able to create child processes in a
> > shared library without the main programing having to know about this so
> > that it can use P_ALL and never get stuff from the library.
> 
> OK, thanks...
> 
> in this case you should probablu pass 0 in CSIGNAL to ensure that the main
> program won't be notified when that child exits.

Yes, that's the idea. So you'd turn off SIGCHLD and rely on pidfd polling
only. That's similar to how pdfork() on FreeBSD works. It's just that we
need to do:
struct clone_args args = {
	.exit_signal = 0,
	.flags = CLONE_PIDFD | CLONE_WAIT_PID,
};
Now the shared library can guarantee that noone else in the mainloop
gets woken by a SIGCHLD from the pidfd-based helper process (because
exit_signal is 0) but afaict it also needs CLONE_WAIT_PID. Since the
latter allows it to guarantee that if someone in the mainloop gets
SIGCHLD from another regular process and calls waitid(P_ALL) it won't
accidently reap a pidfd-based process that has exited.

Fyi, I'm splitting CLONE_WAIT_PID out into a separate patchset and only
keep P_PIDFD for now. So we can discuss this independently. You think
that's better Oleg?

Christian
