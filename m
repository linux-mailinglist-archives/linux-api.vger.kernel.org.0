Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AE4241DE2
	for <lists+linux-api@lfdr.de>; Tue, 11 Aug 2020 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgHKQJ5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgHKQJ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Aug 2020 12:09:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874DC061787
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 09:09:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so14152698ljd.0
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=ARjGfgTTe8Hs0S97+HBco6KPkmP42m5OKE0ERo6Sf2t684ErIUsYZb+F9N6GI8m7VH
         sHrR/7XxUU0WvzcWkmBHB9j/WQDrOrGh9T97uhNn/7Dj2ZTIxVy3Iz23WUYyWjs31hnR
         EPcWsf2mQ8nUFDg+i2/4NJ7eEH6TQJE7uk7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARDqa0ttwGGpwIjIpukccBn4z80sUg1Y95J7pw/cBrc=;
        b=jjvrAseD38LwxZyPgv1YUzPZW74l7W9wJsGEJxpNuyM22KWsYW0krfIFAbV1G4QILz
         dwdjJHk4snAUD/w7Nlr0yeb9X6MtE9VPUVKrXeMGBBqef+NpdF+qm+03WhC/YGN68ABB
         F2ecytbHzhFx6Qvc96Du9sfJGBt15AcRIPKWUmaELzMi/iGmD4aav47k9K4ZGQx4dtTx
         s6KQUn9awR7RxZlBVgXCpeyKeemVNwHTt3IDLTfXugml1RoI1egkeyN/ssBzD4225U4w
         p2W8T94A1nlq7FXvlgeom1DlFrdNryYQiMfUa5UKtLzeHsrGTDeHNQYD5hfz5Mp398Ak
         yScQ==
X-Gm-Message-State: AOAM531C/SGe3fm6Lm/+COMtThkpktrmE7dz2qPBe6SRS+3ovbFwJHup
        lNmqy740Z1vWCwPTXk4f+jeamkC+NxU=
X-Google-Smtp-Source: ABdhPJybdN7U2t65QWJnzE20VsfIdVBWQbx8FPoGaFj7Gthele101K4Mk9QF05xDgZZKqdMITDC6bg==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr3592994ljb.261.1597162194324;
        Tue, 11 Aug 2020 09:09:54 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p9sm10139259ljg.76.2020.08.11.09.09.53
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:09:53 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 185so14134836ljj.7
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 09:09:53 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr3191279ljc.371.1597162192777;
 Tue, 11 Aug 2020 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <20200811160534.GL1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811160534.GL1236603@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:09:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Message-ID: <CAHk-=wgHZig-+dXQeW4pPEjdYsrq=3bgc+vUhwiT2Ox4ipLHwg@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
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

On Tue, Aug 11, 2020 at 9:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Except that you suddenly see non-directory dentries get children.
> And a lot of dcache-related logics needs to be changed if that
> becomes possible.

Yeah, I think you'd basically need to associate a (dynamic)
mount-point to that path when you start doing O_ALT. Or something.

And it might not be reasonably implementable. I just think that as
_interface_ it's unambiguous and fairly clean, and if Miklos can
implement something like that, I think it would be maintainable.

No?

                Linus
