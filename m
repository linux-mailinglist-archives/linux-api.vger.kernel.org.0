Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397D0D539C
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 02:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfJMAqb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 20:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfJMAqa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 Oct 2019 20:46:30 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C919821655
        for <linux-api@vger.kernel.org>; Sun, 13 Oct 2019 00:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570927590;
        bh=Af3xuDOmu2mRlmVHh8KyOwgmi8BjnhCayyjozArl5rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFNSfK2nnknqf6YFpBWiswhdWqZghVAzwLOkXuFG627W92nSo0N5VKik94xJUR6d2
         9CD+Fgek4xkfURdNb1GlJI283z/EqpXfWatZGaljVv9wHnfuHFqUI+Hzq5kH5d1oIw
         cU+h8TENoLgwakgyqMhU5M5q3iSWg2kJktcfg+Js=
Received: by mail-wr1-f45.google.com with SMTP id v8so15658450wrt.2
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 17:46:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXoNpP5etaFOqy+zsHDmr7+kVk9zLKK/CpGPLgSNPd0waTn/64i
        wBmy91Y4qi89uIAE3HhACkgdm9YLKy27+p66659czA==
X-Google-Smtp-Source: APXvYqysITTY9tkM0esE0JJ93/2Q/PuAdhhDrLgBh3/GK6dojhCF2+0RUifa4NNExyW7LOYnqyH2VI9/xqzLzckWab0=
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr4610565wrx.111.1570927588270;
 Sat, 12 Oct 2019 17:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-5-dancol@google.com>
 <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com> <CAKOZuevQD-xsy_PrvT7F3Pqaoo5apZFukj2ZKLLQKup1cwgZ-A@mail.gmail.com>
In-Reply-To: <CAKOZuevQD-xsy_PrvT7F3Pqaoo5apZFukj2ZKLLQKup1cwgZ-A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 17:46:16 -0700
X-Gmail-Original-Message-ID: <CALCETrWFFbgdR3qtsQhxdMbaocoeHHkwpTQ-mQKJ4mgWBHz-Ng@mail.gmail.com>
Message-ID: <CALCETrWFFbgdR3qtsQhxdMbaocoeHHkwpTQ-mQKJ4mgWBHz-Ng@mail.gmail.com>
Subject: Re: [PATCH 4/7] Teach SELinux about a new userfaultfd class
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 5:12 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Sat, Oct 12, 2019 at 4:09 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > Use the secure anonymous inode LSM hook we just added to let SELinux
> > > policy place restrictions on userfaultfd use. The create operation
> > > applies to processes creating new instances of these file objects;
> > > transfer between processes is covered by restrictions on read, write,
> > > and ioctl access already checked inside selinux_file_receive.
> >
> > This is great, and I suspect we'll want it for things like SGX, too.
> > But the current design seems like it will make it essentially
> > impossible for SELinux to reference an anon_inode class whose
> > file_operations are in a module, and moving file_operations out of a
> > module would be nasty.
> >
> > Could this instead be keyed off a new struct anon_inode_class, an
> > enum, or even just a string?
>
> The new LSM hook already receives the string that callers pass to the
> anon_inode APIs; modules can look at that instead of the fops if they
> want. The reason to pass both the name and the fops through the hook
> is to allow LSMs to match using fops comparison (which seems less
> prone to breakage) when possible and rely on string matching when it
> isn't.

I suppose that whoever makes the first module that wants to use this
mechanism can have the fun task of reworking it.  There's nothing
user-visible here that would make it hard to change in the future.
