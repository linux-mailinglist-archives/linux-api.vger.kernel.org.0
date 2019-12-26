Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDB12AD3D
	for <lists+linux-api@lfdr.de>; Thu, 26 Dec 2019 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLZPh6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Dec 2019 10:37:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41193 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfLZPh6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Dec 2019 10:37:58 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so19947049ioo.8
        for <linux-api@vger.kernel.org>; Thu, 26 Dec 2019 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5O98/Q8hWNM3RNsrmMXZZkSL0QH2EUkHvO2fSlNMHBU=;
        b=v2J/ldUG0+9s2t9PIkHIgh3DVPfToU/LOwGE0g36pH/UgYT3h1Djd1EYMYfzG7X6Z0
         SqUa/bzgoe4+yDdF4oS+UEWBDmuTVphm0zkQx/KfGJhXAIDWxwPl6tkOzsD/odqqll8V
         uFlTycY5rfDVXxbENe0ofDFUc0oQ7AB/UsUX5CT7FjQNVOu+GtRiCz3IfQX5EWt/5x2l
         xzv/WqcnZVSJBli71H87/FW4Ky3uxo6WjLilkGSr1peqwGsrO1LDrwCbDVOcc1F2OKAS
         6Rdb2iGVSeLEBe6YrZcRs02aA+RENqO/1afLeXjRPE5yZZ2m8QQO3IBD/joLqHTdvPIJ
         WZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5O98/Q8hWNM3RNsrmMXZZkSL0QH2EUkHvO2fSlNMHBU=;
        b=G9boGKbcUFtnIi0JY8tQtgadGUMcqgDlZVixGH7j5/rWrjpGyOrx0g61A0Gh2fqEQT
         B6O5yRe0aVg1jPDY9sNFE8AuxUOL7NYX8v64o5rJk2jLt+qfZ07xX26GsvbjmlhzHQPL
         LautFhmjU9B2Mfx/cbzW8SfOlvqxWNb7goMcbn8TTH3DcR+TXnP/mOwX50hFNvvI69ln
         rK+fgtMqNDiZzsgZQBIlOYNRpHNa1I322apSOhI/dobKSyAVofzukgmw/CX7VypXvWSX
         ZcmpvB9Q9rUyMxWeS/HfC25CwcaPLqeDXEy4fWxluE9q6nOUH0inqXlV9LlViu93AiSe
         Ed+w==
X-Gm-Message-State: APjAAAVuFwxXexaNeuvHTeLm5Z/wUqKvLGOoY6FwD4d+5pclHR7asZME
        VqoQDY9I5xN+3aTkt+nPazGHeQ==
X-Google-Smtp-Source: APXvYqwiiHPMJ8mO1xOyPk33rGPY1Er1evdQ2D4+x2uIU7Jn8tCfpGr3LvAWiS30DgA4YeYCpD9XwA==
X-Received: by 2002:a02:9988:: with SMTP id a8mr37790039jal.33.1577374677172;
        Thu, 26 Dec 2019 07:37:57 -0800 (PST)
Received: from cisco ([2601:282:902:b340:f166:b50c:bba2:408])
        by smtp.gmail.com with ESMTPSA id 81sm12270971ilx.40.2019.12.26.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 07:37:56 -0800 (PST)
Date:   Thu, 26 Dec 2019 08:37:53 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, keescook@chromium.org
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
Message-ID: <20191226153753.GA15663@cisco>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
 <20191226115245.usf7z5dkui7ndp4w@wittgenstein>
 <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 27, 2019 at 01:32:29AM +1100, Aleksa Sarai wrote:
> On 2019-12-26, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > On Wed, Dec 25, 2019 at 09:45:33PM +0000, Sargun Dhillon wrote:
> > > This patch is a small change in enforcement of the uapi for
> > > SECCOMP_IOCTL_NOTIF_RECV ioctl. Specificaly, the datastructure which is
> > > passed (seccomp_notif), has a flags member. Previously that could be
> > > set to a nonsense value, and we would ignore it. This ensures that
> > > no flags are set.
> > > 
> > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > Cc: Kees Cook <keescook@chromium.org>
> > 
> > I'm fine with this since we soon want to make use of the flag argument
> > when we add a flag to get a pidfd from the seccomp notifier on receive.
> > The major users I could identify already pass in seccomp_notif with all
> > fields set to 0. If we really break users we can always revert; this
> > seems very unlikely to me though.
> > 
> > One more question below, otherwise:
> > 
> > Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > > ---
> > >  kernel/seccomp.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index 12d2227e5786..455925557490 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
> > >  	struct seccomp_notif unotif;
> > >  	ssize_t ret;
> > >  
> > > +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
> > > +		return -EFAULT;
> > > +
> > > +	/* flags is reserved right now, make sure it's unset */
> > > +	if (unotif.flags)
> > > +		return -EINVAL;
> > > +
> > 
> > Might it make sense to use
> > 
> > 	err = copy_struct_from_user(&unotif, sizeof(unotif), buf, sizeof(unotif));
> > 	if (err)
> > 		return err;
> > 
> > This way we check that the whole struct is 0 and report an error as soon
> > as one of the members is non-zero. That's more drastic but it'd ensure
> > that other fields can be used in the future for whatever purposes.
> > It would also let us get rid of the memset() below. 
> 
> Given that this isn't an extensible struct, it would be simpler to just do
> check_zeroed_user() -- copy_struct_from_user() is overkill. That would
> also remove the need for any copy_from_user()s and the memset can be
> dropped by just doing
> 
>   struct seccomp_notif unotif = {};

This doesn't zero the padding according to the C standard, so no, you
can't drop the memset, or you may leak kernel stack bits.

As for the rest of it, while it is an ABI change I think all of the
users are CC'd on this thread, and it's an obvious goof on my part :).
So:

Acked-by: Tycho Andersen <tycho@tycho.ws>

Tycho
