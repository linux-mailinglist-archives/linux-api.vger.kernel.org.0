Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491BA4E922
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfFUN2p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 09:28:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUN2o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 09:28:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so6606838wrs.5
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EMsrpo1moUaH2rHK1LlYi+tUBFSGMr7JAdJB+mRI/g=;
        b=ePuxoeeNHfTWihZvcOuCDGTjMSQJR2s8+iO36eDnxzA2613uotv2mmvRre4mAoyBTH
         tpHZUMHF+W/Gl6aVgY2WlMgOi4JGt/7LoReSbjccE3cOlvYGjvQlqV1PSwbqPLsXYiwc
         Qbty5/DAl6yAmIPjDjKlqz9wHu5liUE2Ezb+Aq99lkDjiz3zaJkziT+iqQ/GDj5N8rzx
         mlbBbYGt0+pd4MFtLT8gN0NsbWg7B1X3DTL3RWXaHw29eyXy4tbP89E8WacQIkQHmrkC
         jU3BInZsYTLHfOgK8SwzIPX+iC+yGTzWH01ZETolkrtW4q/J59eqLmHjKW2zLeZZ021t
         J2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EMsrpo1moUaH2rHK1LlYi+tUBFSGMr7JAdJB+mRI/g=;
        b=gM3J7kR980k5K7DQb0JTUUXn+kZsp363mLRgAytq5DWOlVjhUt5K6ErEY62LlbbOAR
         HcSnJNLw2z/ZfAu2H1JntrintB7IFsM/ecYaXd4XwcU9EL6k/ws/jtMFWbRKcrLbeskd
         0HkZRGWLHmo4fT2X7DSmX/2b+m6mKKTOA62NqCvEJ9NTWURe5QawgLvT2y03dmxup48d
         AfOARx1kGFpIyMKo0wbPICk+6jc1/3RLeFdpezdaAPCTWcUhTukskruRxQfYqBI63xxS
         E9Pxz/vd9L3zbDwHh9Vo8P4EeMt6/2zH5+4AKajkbeSO8g24K9qCrregAG/I8UpnRiF8
         8cdQ==
X-Gm-Message-State: APjAAAWw+N6EZ1QkPfgfVeVpuhSkzdtJBY1IBl6KK3jDnKPJm7vSzlMQ
        KLNAEB1QMMNUQoGF/Lyrm2rYsg==
X-Google-Smtp-Source: APXvYqz7/r+j2/bz2zXC4bWeBw0/AOUH64ui71bNQocHtMgX5fBuIDo4/VDUKh7gVgVmUFvnOKbPGA==
X-Received: by 2002:adf:eacd:: with SMTP id o13mr24607835wrn.91.1561123722303;
        Fri, 21 Jun 2019 06:28:42 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id v15sm2867708wrt.25.2019.06.21.06.28.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:28:41 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:28:40 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an
 fs_context [ver #13]
Message-ID: <20190621132839.6ggsppexqfp5htpw@brauner.io>
References: <20190621094757.zijugn6cfulmchnf@brauner.io>
 <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk>
 <21652.1561122763@warthog.procyon.org.uk>
 <E76F5188-CED8-4472-9136-BDCDFDAF57F0@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E76F5188-CED8-4472-9136-BDCDFDAF57F0@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 03:16:04PM +0200, Christian Brauner wrote:
> On June 21, 2019 3:12:43 PM GMT+02:00, David Howells <dhowells@redhat.com> wrote:
> >Christian Brauner <christian@brauner.io> wrote:
> >
> >> >  static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams
> >*params)
> >> >  {
> >> >  	struct fd f = fdget_raw(fd);
> >> 
> >> You're using fdget_raw() which means you want to allow O_PATH fds but
> >> below you're checking whether the f_ops correspond to
> >> fscontext_fops. If it's an O_PATH
> >
> >It can't be.  The only way to get an fs_context fd is from fsopen() or
> >fspick() - neither of which allow O_PATH to be specified.
> >
> >If you tried to go through /proc/pid/fd with open(O_PATH), I think
> >you'd get
> >the symlink, not the target.
> 
> Then you should use fdget(), no? :)

That is unless you want fsinfo() to be useable on any fd and just fds
that are returned from the new mount-api syscalls. Maybe that wasn't
clear from my first mail.

Is the information returned for:

int fd = fsopen()/fspick();
fsinfo(fd);

int ofd = open("/", O_PATH);
fsinfo(ofd, ...);

the same if they refer to the same mount or would they differ?

Christian
