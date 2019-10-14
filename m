Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E3D6968
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfJNSaf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 14:30:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbfJNSaf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 14:30:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id s22so14623633otr.6
        for <linux-api@vger.kernel.org>; Mon, 14 Oct 2019 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tl4f6x5LaBYnk4O0v99MsRzY3TUmlaFrR8aMs8VHxow=;
        b=YY3BCYHU/puIpC3m1C7ST9z/cleynKgAfruHWL6oXDlKC6WRCZa/wtgFzBUdscWo2D
         +kH+MjVv6Ztu2n2DRbBrgGsyLV61j4t/+Oj4RLwP+/LaWMDDy2P+yIfx+cB0xSb2fSEU
         EcvLBM8vTO1kOprr3LkwP0BsUDZq9Io8o5xLvSY5L17P9NeIWnaql9xRjO68GeyGqWdo
         +HHa0xnhjQ/uGk4hRq116CNqGxl1vBP4Sn2LNV6oEbRaElmLeFODC9Zv9GTJkZAoXOiE
         /H3AXVQq9eNLKSxtsURmb0h6VzQfnmiLlJmzkI91pZpGdYesQp1tl35pgLsL5J+IGf9l
         1mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl4f6x5LaBYnk4O0v99MsRzY3TUmlaFrR8aMs8VHxow=;
        b=N3KSXo0/hBpZTWWtTOktF+KO3rQoP2q1TObnRbFZ29VJjfgZ6YzRcqTaMQxXjgjvzN
         EQJeeBnSkzWJEVPgQEl7Zf38Ty3ixbGuAx3y0aNim4G8yKaizEBTwrZ24tNmRV/OMdTh
         fY6xKugHwEcHJaMaKf4ODZ5rkBQKbq701eQhCguG8iPUOC8vY4Ba1wYSKgnkVk8vSdrv
         0PJwV6jAwGQmoNnKspFo5uggoRMujgm2Jb3aumSUcXaR2/2LNG9KhIl3Y3X9PvktZipt
         NsV4J0bM+T7k8s6UZ96ExYB1zuItEAYnsaK9HR9byUU/cRuUQRc8bEPGCHLTch+3fMIq
         mz9g==
X-Gm-Message-State: APjAAAXJr82R9IdOaYJIGp5sdVwByGK79sT5HML+hb5X/mZI3YYreMRs
        f5yG7WGn0HxsuoYiaLPQ3kdIpq5+SYmcuEOQf3xTxA==
X-Google-Smtp-Source: APXvYqwCbK8UAY4G8UW8Ik4Aqqfmc0uyc/xOU9otg9ZLSwrBkH5yXF/oWyJq1+PXzp3ELrxauM9OAvX0ZYePUDLj4wo=
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr10238245otl.32.1571077834222;
 Mon, 14 Oct 2019 11:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-2-dancol@google.com>
 <CAG48ez3yOPAC3mTJdQ5_8aARQPe+siid5jaa8U+aMtfj-bUJ2g@mail.gmail.com> <CAKOZuet4VM-P_xm9R7cJO2_f60eUcqt5wHG8+khJedhctfEEhw@mail.gmail.com>
In-Reply-To: <CAKOZuet4VM-P_xm9R7cJO2_f60eUcqt5wHG8+khJedhctfEEhw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 20:30:07 +0200
Message-ID: <CAG48ez1Tdm+iz3-H7OZ2v9-zmWg-73zwEsupDxmnEymZM_C3DA@mail.gmail.com>
Subject: Re: [PATCH 1/7] Add a new flags-accepting interface for anonymous inodes
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 14, 2019 at 8:16 PM Daniel Colascione <dancol@google.com> wrote:
> On Mon, Oct 14, 2019 at 8:39 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 9:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > Add functions forwarding from the old names to the new ones so we
> > > don't need to change any callers.
> >
> > This patch does more than the commit message says; it also refactors
> > the body of the function. (I would've moved that refactoring over into
> > patch 2, but I guess this works, too.)
> >
> > [...]
> > > -struct file *anon_inode_getfile(const char *name,
> > > -                               const struct file_operations *fops,
> > > -                               void *priv, int flags)
> > > +struct file *anon_inode_getfile2(const char *name,
> > > +                                const struct file_operations *fops,
> > > +                                void *priv, int flags, int anon_inode_flags)
> >
> > (AFAIK, normal kernel style is to slap a "__" prefix in front of the
> > function name instead of appending a digit, but I guess it doesn't
> > really matter.)
>
> I thought prefixing "_" was for signaling "this is an implementation
> detail and you probably don't want to call it unless you know what
> you're doing", not "here's a new version that does a new thing".

Ah, I guess that might be true.
