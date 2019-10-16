Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D79D95A1
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404947AbfJPPcL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 11:32:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39563 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJPPcK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Oct 2019 11:32:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so24502068ljj.6
        for <linux-api@vger.kernel.org>; Wed, 16 Oct 2019 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4sUXBF9N+gOqGoXUSe/0E2VksmAjHdkiv7KSR2ftGI=;
        b=KN++Zn81C01LK7bngv2WQhecCB2pvDWa6MiPOCNK9giCb55GzPd38NprLWCi9y4Rmp
         G5JVpEFhN07gxtvQKkcodZ0c/iin5yb7op+6svXAeHTJxJPM5HZz2LuFX2hGczINIWnp
         zjAlhPJ3IIlR8ZNhwPZ4TPeH42AI6XYGcDMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4sUXBF9N+gOqGoXUSe/0E2VksmAjHdkiv7KSR2ftGI=;
        b=nx1IwjyxfnoXYTmyu4M5B0J0DBmQ33YZa5ZUGCWRWjc0SsFwU6fdvvrfVdnKqLNvFp
         LpEqqeOXh7JUmrzYTeC23jwqTAKxkMzOyp4NK24PaeIapM9+zAFxnGja5/UJf60h2pku
         t+KYwANA4OjzJB8w/vLQFReNvrCshHRVdQSPdvCbjXTTNgSUL3QNaeiJ/KK/8oez3rOC
         yzwiX2CAoP1fjk0Gh/EAie14Z5+kzAFSgLmZncny7kdOn0lb1LtoxJNnf/MURqMNiBmU
         eGudc2pKAwklX3gJYQvlFzKZg8HvQhbBZaVoNUaBKBcYRoEelIyuH1LrnNtpatQkTdDf
         FIzw==
X-Gm-Message-State: APjAAAWaf1C008IM/IOmfad/+9j0bU33LR0R1DjHUcwGdOu2ozuSLHf3
        3hd83xkBk3FhmG+2OADLZsvIevWsh8k=
X-Google-Smtp-Source: APXvYqwrpHD+KN3kzBgaRAHPR9y4AXE2HdHYpfUSwhaFeZ+chdjTnoFl6ZbH+RLIQdZyB+mzhvVEpw==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr26475307ljg.14.1571239927486;
        Wed, 16 Oct 2019 08:32:07 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h3sm7710642ljf.12.2019.10.16.08.32.05
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:32:06 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 7so24485943ljw.7
        for <linux-api@vger.kernel.org>; Wed, 16 Oct 2019 08:32:05 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr4189350ljf.133.1571239925218;
 Wed, 16 Oct 2019 08:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
 <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com> <6900.1571235985@warthog.procyon.org.uk>
In-Reply-To: <6900.1571235985@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Oct 2019 08:31:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMZR8TWpmRBPytGmWJX=C=-bCb5D2PsCx0LUNemAPexA@mail.gmail.com>
Message-ID: <CAHk-=wgMZR8TWpmRBPytGmWJX=C=-bCb5D2PsCx0LUNemAPexA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
To:     David Howells <dhowells@redhat.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 16, 2019 at 7:26 AM David Howells <dhowells@redhat.com> wrote:
>
> Btw, is there any point in __wake_up_sync_key() taking a nr_exclusive
> argument since it clears WF_SYNC if nr_exclusive != 1 and doesn't make sense
> to be >1 anyway.

Ack, looks sane to me.

We have _very_ few users of nr_exclusive. I wonder if it's even worth
having at all, but it's definitely not worth it here.

I'd love for nr_exclusive to go away and be replaced by WF_ALL
instead. Right now it looks like there is one SGI driver that uses it,
and the sbitmap code. That was all I could find.

Oh well. You removing one case is at last a small amount of progress.

         Linus
