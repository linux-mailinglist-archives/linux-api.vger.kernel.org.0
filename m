Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA32BC1F1
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 21:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKUUKg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 15:10:36 -0500
Received: from avasout04.plus.net ([212.159.14.19]:56903 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUKg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 15:10:36 -0500
Received: from deneb ([80.229.24.9])
        by smtp with ESMTP
        id gZDMkgKCprXCcgZDNkWKbU; Sat, 21 Nov 2020 20:10:34 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q+xJH7+a c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=npldXguGAAAA:8 a=uZvujYp8AAAA:8
 a=B7kAXZeAyjMtkbLiidkA:9 a=CjuIK1q_8ugA:10 a=Z3hCQHVUXPYA:10
 a=sdPHrHSwQQcA:10 a=1MEZn5qd6kv58cYvHi58:22 a=SLzB8X_8jTLwj6mN0q5r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
         s=20191005; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=kJUCMUyKYyuXqI0RqG9nnmlek9nJ2C9wveJjdVf+oeE=; b=YCtwG
        imEel+pY+Xbseesw6CbH9C8ipyXIQbXZb1tgr6d2B2O6MNmpHLnEtRTH/vt2PkJHT5vkL96438KCX
        qXvALJG9gMpyy0ZXAeVUmpOpkB2biIbKtK30cxihhgJhsPcP39N1bmSHCAez6bnT2dO7e6GAQQ1+/
        rThjXCYTvfOw3e+M9yKCIqCQGieA1/Yb7+o7I2LIF42J+grr8mbkuWEdFGvisEnGvEWAB1e1VUczk
        o4iOHYDq5ACFipdbE6rN49tKJ/lx34xtdG15QngxxP//y6IpPI9SH+HvQ/Ilqq30HyeL+e+feD77E
        Z3xSfgor82LeJxMnIRWXMyWxjbEwQ==;
Received: from mac by deneb with local (Exim 4.92)
        (envelope-from <mac@mcrowe.com>)
        id 1kgZDM-0001hG-AT; Sat, 21 Nov 2020 20:10:32 +0000
Date:   Sat, 21 Nov 2020 20:10:32 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "mtk.manpages@gmail.com Adhemerval Zanella" 
        <adhemerval.zanella@linaro.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Problems with the new pthread clock implementations
Message-ID: <20201121201032.GA5620@mcrowe.com>
References: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
 <877dqeo5f5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dqeo5f5.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfAGtLgOr38d223b8NVl+P7/jrz2S4RJJPk2madOZrXDTU4W2UEBgpu9GdK3+tefbByFQkOH23TkeqeH+/wCDI6toXfJIX1bSvRK7GeGTWG9x/Pnrh5KD
 35k+JQV6yCIKv7/4KKuaZHpKjW/H6n9YcoNN/RyipQG9x0LfeRqtGImi
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

On Saturday 21 November 2020 at 20:50:38 +0100, Thomas Gleixner wrote:
> On Sat, Nov 21 2020 at 07:59, Michael Kerrisk wrote:
> > I've been taking a closer look at the the new pthread*clock*() APIs:
> > pthread_clockjoin_np()
> > pthread_cond_clockwait()
> > pthread_mutex_clocklock()
> > pthread_rwlock_clockrdlock()
> > pthread_rwlock_clockwrlock()
> > sem_clockwait()
> 
> Is there any at least rudimentary specification of these functions and
> what they are supposed to do?

The short answer is that they are like their "timed" equivalents, but they
also accept a clockid. The longer answer is at
https://www.austingroupbugs.net/view.php?id=1216 and if you have access to
it
https://www.opengroup.org/austin/restricted/newapis-p1/Additional_APIs_for_Issue_8-part1-changedpages.pdf

HTH.

Mike.
