Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74974464D
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2019 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfFMQuq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Jun 2019 12:50:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33795 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfFMEBA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Jun 2019 00:01:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so9800784ljg.1
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbJVJjV4JHgO+lN2CsoiJmjNN9A/OrzWGNbZgYy8/Gk=;
        b=ZuHB+EFIWdmyBI+Bcm6q34WvnNer+ayYdcSCBHw9qKdJL9RuMOUEPVDSrPOV456jEe
         Mu2BtvM6HHM2VC/dxpIL71LNetzBiC2Kp/5bf8wCUjnRs36qyJeTHEY/nu3+T/gkFmV2
         AKNJR7dBb43TR0xZODVPwIEf0f2Q0JzJ6s+UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbJVJjV4JHgO+lN2CsoiJmjNN9A/OrzWGNbZgYy8/Gk=;
        b=ARXT3FZPGYNrgnWrhk8ugRBY+49+BB32cxwGxKsw6IlD29xEjSLw1tEkmuecySeDLu
         0/jSAnKfyFN9Xcv+fxYoSo+DPF7xxZ34lp93JoEis1FbWE4+xY4uXsRPVmgPlpv9d0TX
         GtWsMlCfsu24hG9ULjlvj3CsY9moO4P3ickmcax1uyCy57RbTzgHBp1DjwYSPzn502ak
         iQC/xSYq4EVvP29xaK+cPfGQKSrc+RFpdCSFSyIotfS3MP0/CIuytYlqb0UUaIFeyCGJ
         CZ1wkaRYxM8r65RGbAvW2RrUJDAt7ZRy8yD+yi/Ml0eXD/n9wOkpuTDxOdsSz8kUzsqM
         gYqw==
X-Gm-Message-State: APjAAAX8fgq3r4/q3VdXxl88WQ4uIKcyc8JYiqzqcXWEYFxs5KzsKjqd
        viZa+DJNlH30N0SFc+boewGxdO4HxNA=
X-Google-Smtp-Source: APXvYqwl7ctCopHF2mjMVrvWHL2TRMCOF/KpqjOryEN1Ks6J3iRUZBxCIVp7BK8YaCoBak6/6spHfQ==
X-Received: by 2002:a2e:658e:: with SMTP id e14mr15696904ljf.147.1560398457372;
        Wed, 12 Jun 2019 21:00:57 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id c19sm343415lfi.39.2019.06.12.21.00.55
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t28so17057721lje.9
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr5616489ljs.44.1560398455064;
 Wed, 12 Jun 2019 21:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225431.p753mzqynxpsazb7@brauner.io>
In-Reply-To: <20190612225431.p753mzqynxpsazb7@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jun 2019 18:00:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
Message-ID: <CAHk-=wh2Khe1Lj-Pdu3o2cXxumL1hegg_1JZGJXki6cchg_Q2Q@mail.gmail.com>
Subject: Re: Regression for MS_MOVE on kernel v5.1
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 12, 2019 at 12:54 PM Christian Brauner <christian@brauner.io> wrote:
>
> The commit changes the internal logic to lock mounts when propagating
> mounts (user+)mount namespaces and - I believe - causes do_mount_move()
> to fail at:

You mean 'do_move_mount()'.

> if (old->mnt.mnt_flags & MNT_LOCKED)
>         goto out;
>
> If that's indeed the case we should either revert this commit (reverts
> cleanly, just tested it) or find a fix.

Hmm.. I'm not entirely sure of the logic here, and just looking at
that commit 3bd045cc9c4b ("separate copying and locking mount tree on
cross-userns copies") doesn't make me go "Ahh" either.

Al? My gut feel is that we need to just revert, since this was in 5.1
and it's getting reasonably late in 5.2 too. But maybe you go "guys,
don't be silly, this is easily fixed with this one-liner".

                      Linus
