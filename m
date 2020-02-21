Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B667716824B
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 16:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBUPtc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 10:49:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37607 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbgBUPtb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Feb 2020 10:49:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so2002374oic.4
        for <linux-api@vger.kernel.org>; Fri, 21 Feb 2020 07:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZq1kXcTzLYMO34ccHleJXhWtfhzhvYI72RXtYcu7d0=;
        b=CdmQEUm8JFubqCiKsGRRwXaaEn4qDiBSqM15yM/guhBqxH9V3QOcf/DPFyjJx3SIXM
         sSKrSthI73C8sGegIXkZRqWATeanB5j2t3Lberqg2CMBchFEPYrStpZ8+fxLyqaeiGG+
         cQm4GkqXK/TmylwKp39PXCVweb+KMzgJ0aox0FOipONF3hu+eaIDomovULMYNUb5FxVI
         Cqq7lrK+ojtFa1C2FZjIb7Ff/Uqb9nHpH+g1vs6gebvrESJbMVm73IvPmLooQ91ao5RV
         ymwGGJagi9SrtWu8R4Abmlj1JTK2CaTlZbXXS007p4Z383xXzfZJn/zrmkIaqZirnaRx
         bR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZq1kXcTzLYMO34ccHleJXhWtfhzhvYI72RXtYcu7d0=;
        b=b4fltoGaKYvvHSY3hAb4ducRzufLTT0gmlNIUVYRjtpQhjkoJypEg5zukIZVKOxjIG
         Vi4vZOgZuk5UBruKFOIqlJUyAa9ccSkh4t5Gxl53SvW4ReSmeoqOjTnQBpHE3vOI+S6N
         egCywfVC+sgagFaG4S+OSbuLUUbuDzGyWCnkapJHTtwZ22/mGYrJcgE3sJ96yefN38ri
         C9wg1sFsr3dVO2MH5o1GOHdO+jY+R7N4rvebdvQxmmanx+6LFq6RCz9qi528bph6jSGH
         XJZ7znlFrSTccyJhDh0IA3SMANl0d+monrMGfB8l7PwSVkPDMPp7/+EynTKipO9ip5rW
         iQBQ==
X-Gm-Message-State: APjAAAWPyzBlzT7jrCFyWmgopJaHR58lXFvky1i+fmBag14g3DLNaCQA
        cdpwhrqvvp0ldwkDQH+DhpEJT/jtIwg4TlTtBxQ9pE+7TK3vXA==
X-Google-Smtp-Source: APXvYqx6oYoFCUHz9LVEwbxSzLX1UA9ybF3b+klYwrM1272ykReKNgP4dv2zTdA7aiz1zUlVmIn0Cga9Tqdx35yo8Ww=
X-Received: by 2002:aca:d954:: with SMTP id q81mr2492691oig.157.1582300170627;
 Fri, 21 Feb 2020 07:49:30 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk>
 <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com> <1808070.1582287889@warthog.procyon.org.uk>
In-Reply-To: <1808070.1582287889@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Feb 2020 16:49:04 +0100
Message-ID: <CAG48ez0+_kO_YL6iO9uA+HjjnHRVHVD-bFq0C=ZLeaGtTMss5A@mail.gmail.com>
Subject: Re: [PATCH 13/19] vfs: Add a mount-notification facility [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 21, 2020 at 1:24 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > > + * Post mount notifications to all watches going rootwards along the tree.
> > > + *
> > > + * Must be called with the mount_lock held.
> >
> > Please put such constraints into lockdep assertions instead of
> > comments; that way, violations can actually be detected.
>
> What's the best way to write a lockdep assertion?
>
>         BUG_ON(!lockdep_is_held(lock));

lockdep_assert_held(lock) is the normal way, I think - that will
WARN() if lockdep is enabled and the lock is not held.
