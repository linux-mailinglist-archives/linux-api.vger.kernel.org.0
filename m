Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67C71D7A90
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEROAZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 10:00:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34207 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgEROAZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 10:00:25 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jagJa-0003EB-VU; Mon, 18 May 2020 14:00:23 +0000
Date:   Mon, 18 May 2020 16:00:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200518140022.dcenxe4l7mm4x6bt@wittgenstein>
References: <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
 <202005171428.68F30AA0@keescook>
 <20200518083224.GA16270@ircssh-2.c.rugged-nimbus-611.internal>
 <20200518124500.5cb7rtjitbiiw3mq@wittgenstein>
 <20200518132355.GB2405879@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518132355.GB2405879@cisco>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 07:23:55AM -0600, Tycho Andersen wrote:
> On Mon, May 18, 2020 at 02:45:00PM +0200, Christian Brauner wrote:
> > On Mon, May 18, 2020 at 08:32:25AM +0000, Sargun Dhillon wrote:
> > > On Sun, May 17, 2020 at 02:30:57PM -0700, Kees Cook wrote:
> > > > On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> > > > 
> > > > I'm going read this thread more carefully tomorrow, but I just wanted to
> > > > mention that I'd *like* to extend seccomp_data for doing deep argument
> > > > inspection of the new syscalls. I think it's the least bad of many
> > > > designs, and I'll write that up in more detail. (I would *really* like
> > > > to avoid extending seccomp's BPF language, and instead allow probing
> > > > into the struct copied from userspace, etc.)
> > > > 
> > > > Anyway, it's very related to this, so, yeah, probably we need a v2 of the
> > > > notif API, but I'll try to get all the ideas here collected in one place.
> > > I scratched together a proposal of what I think would make a not-terrible
> > > V2 API. I'm sure there's bugs in this code, but I think it's workable --
> > > or at least a place to start. The biggest thing I think we should consider
> > > is unrolling seccomp_data if we don't intend to add new BPF-accessible
> > > fields.
> > > 
> > > If also uses read(2), so we get to take advantage of read(2)'s ability
> > > to pass a size along with the read, as opposed to doing ioctl tricks.
> > > It also makes programming from against it slightly simpler. I can imagine
> > > that the send API could be similar, in that it could support write, and
> > > thus making it 100% usable from Go (and the like) without requiring
> > > a separate OS-thread be spun up to interact with the listener.
> > 
> > I don't have strong feelings about using read() and write() here but I
> > think that Jann had reservations and that's why we didn't do it in the
> > first version. But his reservations were specifically tied to fd passing
> > which we never implemented:
> > http://lkml.iu.edu/hypermail/linux/kernel/1806.2/05995.html
> > 
> > But still, worth considering.
> 
> There was a thread about this same time for some other API (I can't
> find it now, but I can dig if you want) that suggests that "read() is
> for data" and we shouldn't use it for control in APIs.

Oh that sounds useful. Though I think you can wait with digging it out
until someone insists on using read(). :)

Christian
