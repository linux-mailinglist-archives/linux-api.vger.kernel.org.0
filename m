Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072B4F777B
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKPQ0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 10:16:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41505 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKKPQ0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 10:16:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so11516422oty.8
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=leQP7w6Wd8/nHQ8w8DwldOm2MjClO/82CYqD+qmowYg=;
        b=JsQskc9U6qWQPqhpsIpTIYY5TrCAee8ZhIkjRkRg71HFWa6n6t7/3VNRCRT2ljanm1
         Xpcpy319ZXaKl4BZJD2TY17PxCEvb2+4TnU2/cEvChEeB4S5nnMWuRz+EoqGxLLa3769
         g2hzp29p+NPHE9p9xbaRT65sXJb3h4uagGoxMUghDVuRl0UZ+76I6se6593aRbqixGOi
         6QRRt+IxQMdhOwDOMcsKVxo5bzg9cPXxeqJXIJnoed5WCsD6uQ7fQK1SPylHGSKZgtSv
         SS0o0eWEwg92MBbcZccHVkzrpdgrkhAPY5nHVFt9kH1G7EQfAtyX8/KGGP/w/BWwm5/G
         w3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=leQP7w6Wd8/nHQ8w8DwldOm2MjClO/82CYqD+qmowYg=;
        b=f3idNV+cJ7vgeAXbDmrGCCOB3hJIkgtI5xKCQ1LMPWHox35If27S5Or03IJmmQM+kV
         IVLy6/UyZuIgySGCWd3FDWY3XZ3tdly1ptkZzyPXXPbaWNCFg0m0Fs2vDAk02WLC2Z00
         odwfLtYGB2DLr+f62qPr3ZnBNZaeJiWDX5+yRJzybU4wyW7dy++1sFC0VhyIzYJOUJh8
         ewMCY7uARYHcA3Ji8APjYhsX/uxfRzXba2mgabJID+udMgh64UqP/CwwFY0BP+3bKbiE
         3/JF0QTLhB4Hd9l5xai1Vrg3FaATIgsElzTZWPTdIgNNTwUOHZYx4Ctrq7Ikv4+ICnsJ
         xuaA==
X-Gm-Message-State: APjAAAVpZNd2VqgYumya2WyNXUWLiNE6XnYqGyk1NWGzTpeA1Z5Asv7+
        zonbipLRBL5Ep/scEq+Fx3H2tlGQaGvXn8X5Tr5r9g==
X-Google-Smtp-Source: APXvYqyt/IkbFIh9Cl1Lv8X68IFC1LWWvUcr8H+wBhmRbeRhg4F6LhQKaLJoxWurrZgZN5uSlVIhyPCFQuyVf+dyubk=
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr12701581otb.183.1573485384956;
 Mon, 11 Nov 2019 07:16:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <87tv7awj4g.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87tv7awj4g.fsf@oldenburg2.str.redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 11 Nov 2019 16:15:58 +0100
Message-ID: <CAG48ez3zpBwU6vHSuY6VoP+Uw_Jz6uxYN1Teg2wSpwZrPmAn-g@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 11, 2019 at 4:03 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Michael Kerrisk:
>
> >        Another  difference  for  the  raw clone() system call is that t=
he
> >        stack argument may be NULL, in which case the child uses a  dupl=
i=E2=80=90
> >        cate  of the parent's stack.  (Copy-on-write semantics ensure th=
at
> >        the child gets separate copies of stack pages when either  proce=
ss
> >        modifies  the  stack.)   In  this case, for correct operation, t=
he
> >        CLONE_VM option should not be specified.  (If the child shares t=
he
> >        parent's  memory  because of the use of the CLONE_VM flag, then =
no
> >        copy-on-write duplication occurs and chaos is likely to result.)
>
> I think sharing the stack also works with CLONE_VFORK with CLONE_VM, as
> long as measures are taken to preserve the return address in a register.

That basically just requires that the userspace function declaration
for clone3 includes __attribute__((returns_twice)), right?
