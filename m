Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82A1242A12
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHLNJn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgHLNJm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 09:09:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38818C061788
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 06:09:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cq28so1462162edb.10
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDaKIw34dbl2BS19WgtGHw4f1WrFR2cMDs9vgYrFqRA=;
        b=f3imS+8nyoc+AeGEyfplnYFj1FbYpGqeslu9w52ddIfQ/9dI/X2nGcCAKVKStLE6Dp
         9/bG54SxegeZiSz6ojev1zwm6xgk7bREoz2f33F4iLpDVdGYn749mq7xMDWbwNmnTo5r
         sy2qzQIlhF5PDon4IfaUAfEgRmQOA5q+0cTuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDaKIw34dbl2BS19WgtGHw4f1WrFR2cMDs9vgYrFqRA=;
        b=rp50+Z4/oVeMc2inRmqZLUYYUuQZctmb9VSHEktqUPMk/fqtX3Rdu+U5+90jTsmkD+
         XGegqeO4zeHTl+zjd9IBymBE86UYoOVvjpcgxGwoxpEux5bT1Jqyv+Pjhh1dwmbmQMLk
         m/ECSNsUjm/AXlWJtFT3AM/ZL23ttt/Y8pyalmmsasHBHQ2U6Ph1JmHMtPnizUox4XtM
         Y7qpKcAb9RO/200HPLQue6MJCE9yW7Ltbzodm3oD8uAcCkEZZnXQkb1p5vw/AxzyKmf1
         Vj6Cc1iv2M2m3xporZoN+8m+eTWEhETrzJv2xD9SBTI6qiT7sGDpTzgWO3nUNsNgLgFV
         jpKg==
X-Gm-Message-State: AOAM530ZNe5ZvoJ+KQgEjpbueJlqQgwrWIo2INp6+oQjC/XIraGUcNo0
        25McaBuFioH0tQFW60r/68I7Mi5AT9MOS1hep5YFow==
X-Google-Smtp-Source: ABdhPJy+Hr/67owQkNGvK1aBkG90FSTzz/k2k/Fp5hemfnktI3EmSZYkogSqjcd19XWiEp4n5RNRJT0KfkhES6hsxXo=
X-Received: by 2002:a50:fb10:: with SMTP id d16mr31093480edq.134.1597237777804;
 Wed, 12 Aug 2020 06:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200812101405.brquf7xxt2q22dd3@ws.net.home>
In-Reply-To: <20200812101405.brquf7xxt2q22dd3@ws.net.home>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 15:09:26 +0200
Message-ID: <CAJfpegs4gzvJMBz=su8KgXXxX41tv8tVhO88Eap9pDeHRaSDPA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Karel Zak <kzak@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 12, 2020 at 12:14 PM Karel Zak <kzak@redhat.com> wrote:

> For example,  by fsinfo(FSINFO_ATTR_MOUNT_TOPOLOGY) you get all
> mountpoint propagation setting and relations by one syscall,

That's just an arbitrary grouping of attributes.

You said yourself, that what's really needed is e.g. consistent
snapshot of a complete mount tree topology.  And to get the complete
topology FSINFO_ATTR_MOUNT_TOPOLOGY and FSINFO_ATTR_MOUNT_CHILDREN are
needed for *each* individual mount.  The topology can obviously change
between those calls.

So there's no fundamental difference between getting individual
attributes or getting attribute groups in this respect.

> It would be also nice to avoid some strings formatting and separators
> like we use in the current mountinfo.

I think quoting non-printable is okay.

> I can imagine multiple values separated by binary header (like we already
> have for watch_notification, inotify, etc):

Adding a few generic binary interfaces is okay.   Adding many
specialized binary interfaces is a PITA.

Thanks,
Miklos
