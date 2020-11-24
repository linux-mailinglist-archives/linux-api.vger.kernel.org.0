Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CD2C2902
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgKXOII convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 24 Nov 2020 09:08:08 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:37572 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgKXOIH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 09:08:07 -0500
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 6205C301B4A6;
        Tue, 24 Nov 2020 15:08:05 +0100 (CET)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 17CBC413CE8D; Tue, 24 Nov 2020 15:08:05 +0100 (CET)
Message-ID: <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
From:   Mark Wielaard <mark@klomp.org>
To:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Date:   Tue, 24 Nov 2020 15:08:05 +0100
In-Reply-To: <878saq3ofx.fsf@oldenburg2.str.redhat.com>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
         <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
         <878saq3ofx.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Just a reply to note that this isn't just an issue for glibc, but for
any program that might use linux syscalls directly (with fallbacks).

On Tue, 2020-11-24 at 13:54 +0100, Florian Weimer wrote:
> 
> I agree that the standard should mandate ENOSYS, and I've just proposed
> a specification change here:
> 
>   <https://groups.google.com/a/opencontainers.org/g/dev/c/8Phfq3VBxtw>
> 
> However, such a change may take some time to implement.

Thanks, that is really appreciated. We face the same issue in valgrind.

> Meanwhile, we have the problem today with glibc that it wants to use the
> faccessat2 system call but it can't.  I've been told that it would make
> glibc incompatible with the public cloud and Docker.  The best solution
> I could come up with it is this awkward probing sequence.  (Just
> checking for the zero flags argument is not sufficient because systemd
> calls fchmodat with AT_SYMLINK_NOFOLLOW.)
> 
> I do not wish to put the probing sequence into glibc (upstream or
> downstream) unless it is blessed to some degree by kernel developers.  I
> consider it quite ugly and would prefer if more of us share the blame.
> 
> We will face the same issue again with fchmodat2 (or fchmodat4 if that's
> what it's name is going to be).

For valgrind the issue is statx which we try to use before falling back
to stat64, fstatat or stat (depending on architecture, not all define
all of these). The problem with these fallbacks is that under some
containers (libseccomp versions) they might return EPERM instead of
ENOSYS. This causes really obscure errors that are really hard to
diagnose.

Don't you have the same issue with glibc for those architectures that
don't have fstatat or 32bit arches that need 64-bit time_t? And if so,
how are you working around containers possibly returning EPERM instead
of ENOSYS?

Thanks,

Mark
