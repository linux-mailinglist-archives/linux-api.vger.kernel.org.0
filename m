Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9440D631
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhIPJ2n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Sep 2021 05:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235237AbhIPJ2n (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 Sep 2021 05:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF87B60EE5;
        Thu, 16 Sep 2021 09:27:21 +0000 (UTC)
Date:   Thu, 16 Sep 2021 11:27:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 09:47:25AM -0700, Andy Lutomirski wrote:
> On Wed, Sep 15, 2021 at 8:50 AM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > Hi,
> >
> > I would like to propose a new syscall that exposes the functionality of
> > request_module() to userspace.
> >
> > Propsed signature: request_module(char *module_name, char **args, int flags);
> > Where args and flags have to be NULL and 0 for the time being.
> >
> > Rationale:
> >
> > We are using nested, privileged containers which are loading kernel modules.
> > Currently we have to always pass around the contents of /lib/modules from the
> > root namespace which contains the modules.
> > (Also the containers need to have userspace components for moduleloading
> > installed)
> >
> > The syscall would remove the need for this bookkeeping work.
> 
> I feel like I'm missing something, and I don't understand the purpose
> of this syscall.  Wouldn't the right solution be for the container to
> have a stub module loader (maybe doable with a special /sbin/modprobe
> or maybe a kernel patch would be needed, depending on the exact use
> case) and have the stub call out to the container manager to request
> the module?  The container manager would check its security policy and
> load the module or not load it as appropriate.

I don't see the need for a syscall like this yet either.

This should be the job of the container manager. modprobe just calls the
init_module() syscall, right?

If so the seccomp notifier can be used to intercept this system call for
the container and verify the module against an allowlist similar to how
we currently handle mount.

Christian
