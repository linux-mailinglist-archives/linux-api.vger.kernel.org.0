Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B976516602C
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgBTO6h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 09:58:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41623 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgBTO6h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 09:58:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so27769163oie.8
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpwkKx7E4F4iGPP1d6IgP9CAngaHu/jtsv9MUOt6i20=;
        b=rhM3j0x8usrirIjQD0qjSQ9jCCkuL46j6a4GYkPXKtnSgcJhk6Hx9Th+jZf4OPWbqZ
         EDZz3oWYIE9EiZWJqp2PUKigyRRw/t6Q8UH8RqgRNGsTWV2dv9mCr2DcH4z2bQQ+xk2z
         kYwaMe7GObMMSex4qojHOfzhjSgF0C0TaHxJYt1mQa7h1Ewq+OWpkkTj9lDdiomRk5M6
         rRTAz/AFKDZMNW7yS5X69XPQn0UBAe7qzflPdGZWJ08eh9do95UBp6tUxa/M6BwZpMHp
         3HF+uapICKyFdhOCgDzsKDrdTMOx5Xl1lWUMDmdY/3QoY8XGcpsi8+IoC8lTU4JBx+35
         OQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpwkKx7E4F4iGPP1d6IgP9CAngaHu/jtsv9MUOt6i20=;
        b=O5EKjZsws+Xa9JIHQXnnNacIVwswiyCEmKk6f7wA1YelYdFWL08Ni8AFQepan2pKH8
         bns5B2u1Rshm+jtXSO27/rc8woqSj+IddhxQVQVHdX17XIuY/idE988T8LcSxIzzfBsp
         Bp6/MRujuB61IrTskfgZHvF62LvGKd05lK14pxopqEb2QlT2+Ozl1sopBYCdDV+x5uXp
         /xM3AG2wR2xEm9sLdmYkluPQ2rABPOgMlGOB7SfmdMqmXgnYjXKU6V119s/sIRk6F9m2
         6hBfwPf+LHmkpb9WJCw35l8RgiPGzVywlHd2gcaZTe/9NQE9SgRllWcc+pkR6SrdCU3F
         rdjw==
X-Gm-Message-State: APjAAAXJEjjcxiCeh6P/uT7i7GYxJcOWXHVs/om2MEo+jEVVdvXQQAx/
        2OzPm3wrG4Jtij+cdppe//y8HA63ZCp5uQkKaijzQo/CSsA=
X-Google-Smtp-Source: APXvYqwLZrWv2noarPLEsgl5QTqzBVLNEume/NYspxHkGbrXT7XqrvirpoDtoOYD8R+IEePb15ICBTNX5VckUg08Qbg=
X-Received: by 2002:aca:b187:: with SMTP id a129mr2344580oif.175.1582210716581;
 Thu, 20 Feb 2020 06:58:36 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk>
 <CAG48ez0fsB_XTmNfE-2tuabH7JHyQdih8bu7Qwu9HGWJXti7tQ@mail.gmail.com> <628199.1582203532@warthog.procyon.org.uk>
In-Reply-To: <628199.1582203532@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 20 Feb 2020 15:58:10 +0100
Message-ID: <CAG48ez03VMKEmJEmViSkxbF9J5dW=6vny9vKGdenBewtjF+nqQ@mail.gmail.com>
Subject: Re: [PATCH 11/19] afs: Support fsinfo() [ver #16]
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

On Thu, Feb 20, 2020 at 1:59 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > Ewww. So basically, having one static set of .fsinfo_attributes is not
> > sufficiently flexible for everyone, but instead of allowing the
> > filesystem to dynamically provide a list of supported attributes, you
> > just duplicate the super_operations? Seems to me like it'd be cleaner
> > to add a function pointer to the super_operations that can dynamically
> > fill out the supported fsinfo attributes.
> >
> > It seems to me like the current API is going to be a dead end if you
> > ever want to have decent passthrough of these things for e.g. FUSE, or
> > overlayfs, or VirtFS?
>
> Ummm...
>
> Would it be sufficient to have a function that returns a list of attributes?
> Or does it need to be able to call to vfs_do_fsinfo() if it supports an
> attribute?
>
> There are two things I want to be able to do:
>
>  (1) Do the buffer wrangling in the core - which means the core needs to see
>      the type of the attribute.  That's fine if, say, afs_fsinfo() can call
>      vfs_do_fsinfo() with the definition for any attribute it wants to handle
>      and, say, return -ENOPKG otherways so that the core can then fall back to
>      its private list.
>
>  (2) Be able to retrieve the list of attributes and/or query an attribute.
>      Now, I can probably manage this even through the same interface.  If,
>      say, seeing FSINFO_ATTR_FSINFO_ATTRIBUTES causes the handler to simply
>      append on the IDs of its own supported attributes (a helper can be
>      provided for that).
>
>      If it sees FSINFO_ATR_FSINFO_ATTRIBUTE_INFO, it can just look to see if
>      it has the attribute with the ID matching Nth and return that, else
>      ENOPKG - again a helper could be provided.
>
> Chaining through overlayfs gets tricky.  You end up with multiple contributory
> filesystems with different properties - and any one of those layers could
> perhaps be another overlay.  Overlayfs would probably needs to integrate the
> info and derive the lowest common set.

Hm - I guess just returning a list of attributes ought to be fine?
Then AFS can just return one of its two statically-allocated attribute
lists there, and a filesystem with more complicated circumstances
(like FUSE or overlayfs or whatever) can compute a heap-allocated list
on mount that is freed when the superblock goes away, or something
like that?
