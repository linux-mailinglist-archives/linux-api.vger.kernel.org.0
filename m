Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF462D533A
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfJLXKa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 19:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfJLXK3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 Oct 2019 19:10:29 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D757E206A1
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570921829;
        bh=pj1lahYRxdOI7yK2NaSV1oz91qxQgkYl173+fPCkuTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ToLqH5oB9/3AEQRZ8q4dIYOZpjVOYIdrCsbcApF+aH8sFNXIaHKvs7RVa3t3LGKE3
         1lRiyjwghxsWx7gaZQZyXeCzLnsPthXVyDgaZv0qnnlX3qhmup23BPLzyu67SMJYs4
         AuBkuHS6Vm/qbVtO7LpEDMqSAHw0duh4NvT7Vp5k=
Received: by mail-wm1-f46.google.com with SMTP id i16so13599548wmd.3
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 16:10:28 -0700 (PDT)
X-Gm-Message-State: APjAAAVr5Qkl/va0PQYD9B6uYZVd9JR1FhllmD3dRAam7+VhDPgKBZef
        g1IF/6wFzdQSKSBKorWM8cg68nDHxP9C+hbiaZCpAQ==
X-Google-Smtp-Source: APXvYqxk6sc3V+DoG6q16IAAiOUcHkfVGi48eLgWPixOr9RdOxWUIrKCvNSu8sPAzqcgphvKAuXhJq78vpHDsSBLWbE=
X-Received: by 2002:a1c:a556:: with SMTP id o83mr9383160wme.0.1570921827409;
 Sat, 12 Oct 2019 16:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
In-Reply-To: <20191012191602.45649-4-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 16:10:16 -0700
X-Gmail-Original-Message-ID: <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
Message-ID: <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lokeshgidra@google.com,
        Nick Kralevich <nnk@google.com>, nosh@google.com,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
>
> The new secure flag makes userfaultfd use a new "secure" anonymous
> file object instead of the default one, letting security modules
> supervise userfaultfd use.
>
> Requiring that users pass a new flag lets us avoid changing the
> semantics for existing callers.

Is there any good reason not to make this be the default?

The only downside I can see is that it would increase the memory usage
of userfaultfd(), but that doesn't seem like such a big deal.  A
lighter-weight alternative would be to have a single inode shared by
all userfaultfd instances, which would require a somewhat different
internal anon_inode API.

In any event, I don't think that "make me visible to SELinux" should
be a choice that user code makes.

--Andy
