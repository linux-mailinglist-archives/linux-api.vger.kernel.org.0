Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A69D535E
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfJMAMR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 20:12:17 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40247 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfJMAMR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 20:12:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id v10so8610558vsc.7
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 17:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEI0RfuwpmYZ28QC0mx//1lBf0qrUdX1GPcBJkQZa9U=;
        b=rpQ9RwrNqsQGBr1oAkL/gitja6UMt6gVklBif64wqVq6Tgon/KznC+ZgL6HK3q8QX3
         C5rIWw3jGcpmWJiH7tmNg6HVbxIpaTuTDMFQyG49BEqqu7TsMehEeFFy7QEhCVmrk1eu
         yv7fTAAISHN9cePomO4qg+l1yIKdebEmQSqT3sabeudcw6FlJok25HOFFDhudW/DRsTW
         Ycmrjd/NNLbIo4Yx7FCFBzN5/E+A70AJMna05Lh3GlMj9sBTbGx9gg+epSY2/S6t9ifo
         pjCe5FLiRv5/ZCC1POwOAbnKC/3bAoNmBWoEJvzPfHzp7JxnG0jD/SpNptQe45Jb8aCw
         GEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEI0RfuwpmYZ28QC0mx//1lBf0qrUdX1GPcBJkQZa9U=;
        b=sVUj+D3kWZD/DwBPXDrdTxbDbddx+RKhR7AapL66QRrqeVksTvIz06BiAWqNBO/tOh
         MmqmJru/DwtnfjXtmWQDAtMcwPTBaGrSrKAKYkvdo67kKdfa6Bu4Mn9Tc+FqzQL4/PPa
         LVfMndwSqd5rmJXaRFMNWHtUjpEtATP/SIlcj5BQz65OYcjjJzA7N13w8czXLYdXTfnF
         LQDe7dTt2vg/cT1pYHthcEcQVIotw6YCmI6Cqs1TJTBY/DijH8aFnZi6UeNoBWadOUr9
         MzIMzpfW2zD4o/R9m1gv1pfOoV2jgwlSrs8mZLtm2stQ/uwfBhmynWnc4Kuqp5SDtU00
         yJCA==
X-Gm-Message-State: APjAAAUVMxIWIEQSPyGxaZLFtMjqfrh03dxL/Mjsyd/DkbhzHzrpVnzp
        qbgLngr6NNj4g584JXhnXDGTr6sflW2jf8UhJEW1qRsbyfk=
X-Google-Smtp-Source: APXvYqxj5NmmNy49o6iB7yqJhqzkcQYhEtu5i1Mv03KaNdvvSxlYaJl2qsOIZ5v4l7hTNSnU1Q4nTOVljy2cDmWu+/M=
X-Received: by 2002:a67:db16:: with SMTP id z22mr13135311vsj.171.1570925536096;
 Sat, 12 Oct 2019 17:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-5-dancol@google.com>
 <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com>
In-Reply-To: <CALCETrVmYQ9xikif--RSAWhboY1yj=piEAEuPzisf+b+qEX4uA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 12 Oct 2019 17:11:40 -0700
Message-ID: <CAKOZuevQD-xsy_PrvT7F3Pqaoo5apZFukj2ZKLLQKup1cwgZ-A@mail.gmail.com>
Subject: Re: [PATCH 4/7] Teach SELinux about a new userfaultfd class
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
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

On Sat, Oct 12, 2019 at 4:09 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > Use the secure anonymous inode LSM hook we just added to let SELinux
> > policy place restrictions on userfaultfd use. The create operation
> > applies to processes creating new instances of these file objects;
> > transfer between processes is covered by restrictions on read, write,
> > and ioctl access already checked inside selinux_file_receive.
>
> This is great, and I suspect we'll want it for things like SGX, too.
> But the current design seems like it will make it essentially
> impossible for SELinux to reference an anon_inode class whose
> file_operations are in a module, and moving file_operations out of a
> module would be nasty.
>
> Could this instead be keyed off a new struct anon_inode_class, an
> enum, or even just a string?

The new LSM hook already receives the string that callers pass to the
anon_inode APIs; modules can look at that instead of the fops if they
want. The reason to pass both the name and the fops through the hook
is to allow LSMs to match using fops comparison (which seems less
prone to breakage) when possible and rely on string matching when it
isn't.
