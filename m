Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A32249C4
	for <lists+linux-api@lfdr.de>; Sat, 18 Jul 2020 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGRIGA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Jul 2020 04:06:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45872 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgGRIGA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 18 Jul 2020 04:06:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595059558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGBqwoFB6z1OOsQGdK3k+zSFcykqsD4+tGGRSlXQyrs=;
        b=Pvw4mj8/b3xwOONiGbWpl/notHH9jJQxBqfeArhWFW1BsNseEFpco6RkHGbwGMH1702WD2
        b/Xzq34uMTvrn8dPcvNjtUqnSEghbI5caRPkPPGQ+xcNqHJM7PD2T4nVnP60+DCuEdG+Vi
        Q7L0ADrzXSSaQHZH9RFA1BsALPANqGFytjL1dbyhf//WW1On3vl3tvwwYDgCAR5dVcESZV
        8xXNW35rjLj9DI1nplPG5hBeDqSCez4xAXSmXjQnw+olb/RzWi/2tAsmsdP4FGj+hmyr/J
        haeOxNScKBTzTcmAh2xWrGm8Q+aY4kbQPT2WYx640165/toqOUguwrCW7yK5YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595059558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGBqwoFB6z1OOsQGdK3k+zSFcykqsD4+tGGRSlXQyrs=;
        b=v8lqGH+hAYkfh3l467X0p0O2jtETva7BYGMb/FGLPlbJ3q5wpJRyWOuw0rEODSl503y00F
        X9LxH7p4Hci32ACA==
To:     Minh =?utf-8?Q?B=C3=B9i?= Quang <minhquangbui99@gmail.com>,
        trivial@kernel.org
Cc:     linux-api@vger.kernel.org
Subject: Re: [PATCH] syscall.h: fix comment
In-Reply-To: <CACtPs=FWBJb-WmKGau56euj8Mt_pAXAF5jY-DdjhTV7pa6h4jA@mail.gmail.com>
References: <20200717104517.2275-1-minhquangbui99@gmail.com> <87k0z1ptbu.fsf@nanos.tec.linutronix.de> <CACtPs=FWBJb-WmKGau56euj8Mt_pAXAF5jY-DdjhTV7pa6h4jA@mail.gmail.com>
Date:   Sat, 18 Jul 2020 10:05:57 +0200
Message-ID: <878sfhp7ru.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


     A: Because it messes up the order in which people normally read text.
     Q: Why is top-posting such a bad thing?

     A: Top-posting.
     Q: What is the most annoying thing in e-mail?

     A: No.
     Q: Should I include quotations after my reply?

Minh B=C3=B9i Quang <minhquangbui99@gmail.com> writes:
> Hi, I actually find the file reference quite useful for me to look for
> syscalls definition.

git grep is your friend and always works while file references are bound
to become stale when stuff moves around.

Thanks,

        tglx
