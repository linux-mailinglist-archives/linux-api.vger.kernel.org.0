Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A49923A32E
	for <lists+linux-api@lfdr.de>; Mon,  3 Aug 2020 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHCLRU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Aug 2020 07:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCLRT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Aug 2020 07:17:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DDC06174A
        for <linux-api@vger.kernel.org>; Mon,  3 Aug 2020 04:17:19 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so13215617edv.11
        for <linux-api@vger.kernel.org>; Mon, 03 Aug 2020 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phUao9tXf/t4b/68S+2rq16ySbBLGNbfI2sRyl9fmdU=;
        b=eoVrCN0PZZ1JS+F3fakDr2Ij8wISyKSGPN0lWQaGRrdbv1WtI1HXeY2zQorKnB7Bi0
         VRrysLvCQG2nw4yx00kjhBBvbRQCdLC+pMBHaFd4x+oUq5/iuV61KNUXUtmKl/01yaYQ
         K72k3pKjdfjjKvewHfPgkAHJIvr563YyPdSN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phUao9tXf/t4b/68S+2rq16ySbBLGNbfI2sRyl9fmdU=;
        b=X6KuBtIohNbuZSsepWbKt9+sWQpGH7kDWYXpm0LropVbrrmQjQMaVxi4hIqZuKA+Pu
         hHmrHRZQq8QyAfrfRLrtGko6G0ovp3pyZmM10LOgpo/0vdZgQFtbE9daNsu1zFuT6Qtw
         /P7TBaI7Bi9wcjiCcNig0u6WxnYhCQn4Gfl8phkew+i+66vQECe4dceB4I7j1mSkAMLr
         q4b2xOXfGXBSxynmfrnmuzdKNLdzIdZ/Z2GQEENA2EYqTu0zapv8NobSBYyfbkYvU9O7
         od8zWcf7PGJuxeGtDnG9b11P3CeZenvekR1QyXgKa/J9qc1hWamk024f+Jo/hLeXu5hv
         V1QA==
X-Gm-Message-State: AOAM533SQTrTGo3vr3iXXVSdlfcoemrfXkDgd3OzbBd5m+gqdRgwlTow
        B1yYtCukjlbT3OW/YcJSDRv7Xev4LovDLScU4jXMIw==
X-Google-Smtp-Source: ABdhPJzYkpExpfofwOysvG0SUfDHJUUcNoJnQSIchQHGMGBM9qKDjKahkgN9Xb26C1GwbhowgmIILXMGk8ZjU9gsAgI=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr303427edx.161.1596453438170;
 Mon, 03 Aug 2020 04:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <2003787.1595585999@warthog.procyon.org.uk> <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
 <2023286.1595590563@warthog.procyon.org.uk> <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
 <1283475.1596449889@warthog.procyon.org.uk>
In-Reply-To: <1283475.1596449889@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 13:17:06 +0200
Message-ID: <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 3, 2020 at 12:18 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > fsinfo() then allows you to retrieve them by path or by mount ID.
> >
> > Shouldn't the notification interface provide the unique ID?
>
> Hmmm...  If I'm going to do that, I have to put the fsinfo-core branch first
> otherwise you can't actually retrieve the unique ID - and thus won't be able
> to make sense of the notification record.  Such a rearrangement might make
> sense anyway since Ian and Karel have been primarily concentrating on fsinfo
> and only more recently started adding notification support.

OTOH mount notification is way smaller and IMO a more mature
interface.  So just picking the unique ID patch into this set might
make sense.

Thanks,
Miklos
