Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3AECB21
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2019 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfKAWMp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 Nov 2019 18:12:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40499 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfKAWMo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 Nov 2019 18:12:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id q2so5126612ljg.7
        for <linux-api@vger.kernel.org>; Fri, 01 Nov 2019 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=O3mYYvlU9vmiWCuVM7D5zeynWjET9sBTNe2UP3ZA3GeXbBriHFMqoPk2kJgyTgcAeI
         BstBtBLU16kkJaWSMcP9+57VaYHHgUIqojJCqULremk/l27m2Dlyko2Sd9hhC3Y74UKd
         ZPG4og+yRVtEHOd/O+5D/qMCxYtxUKUSxHi24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgYt+P3xDWHpqkCDVDLjgLKgMrsRwGebg6HQkCjAc5w=;
        b=aqxoX5Blq1k5TqN25tSciCJ7v7r3VhrZ54I4oO5OiNYUWL9Fw8yvOL1NHHb9tFXRuS
         z0jhuTls6bWGf+V5uBtKUcz1toeqpWaINZ9kt8aVbUt6lzQgcvfe10gBQqynLa8I2FCa
         4ChKJApjHe/KxFn0hOD+LMN+7jPt/17/KbpB0MxqhMhgJOpjZIwnE2M+ZfCFwZsPjat+
         68azztnbZnT8pnAjQZriwjH0PST+bFtC/uoAJXKtBbIgldsSybhQsmynYShsg+bGS5Dd
         0WmHGfMoaIY3At4SSDzjNmo19CRZ+P7z1KNzUm0FOgM3iPOmKRE12wJT/kDvGgbY3UEM
         TNiA==
X-Gm-Message-State: APjAAAX9yYYzJ+V/SSuJoj/e8Z4hlBzdBiQMcBp7D6PJpzLrN8zHCaJh
        JIaPSZVu9TrkdsbivwIpjAazstBIau4=
X-Google-Smtp-Source: APXvYqy0vKLU07+9g3xAq3TJVrwsXnTr/tgHx95+W7qLLFlBWO4fTiUejE8XOOvsdPbBGBpphKUBbA==
X-Received: by 2002:a2e:a304:: with SMTP id l4mr718045lje.178.1572646361989;
        Fri, 01 Nov 2019 15:12:41 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id t8sm2555749lfl.51.2019.11.01.15.12.40
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id f4so8245879lfk.7
        for <linux-api@vger.kernel.org>; Fri, 01 Nov 2019 15:12:40 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr8678681lfc.79.1572646359613;
 Fri, 01 Nov 2019 15:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
 <CAHk-=wjqx4j2vqg-tAwthNP1gcAcj1x4B7sq6Npbi8QJTUMd-A@mail.gmail.com> <13964.1572645926@warthog.procyon.org.uk>
In-Reply-To: <13964.1572645926@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 15:12:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Message-ID: <CAHk-=wg_Fb-WdcD-cbJjwZaPCNK4WZ+Ak4KTSDhopD-_=+t=9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] pipe: Notification queue preparation [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Fri, Nov 1, 2019 at 3:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Changing those to non-sync:

Your benchmark seems very insensitive to just about any changes.

I suspect it is because you only test throughput. Latency is what the
pipe wakeup has been optimized for, and which tends to be much more
sensitive to other changes too (eg locking).

That said, I'm not convinced a latency test would show much either.

               Linus
