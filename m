Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C35BABEE7
	for <lists+linux-api@lfdr.de>; Fri,  6 Sep 2019 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395263AbfIFRkq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Sep 2019 13:40:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395262AbfIFRkp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Sep 2019 13:40:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3876867pgj.7
        for <linux-api@vger.kernel.org>; Fri, 06 Sep 2019 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zO1msM12y6bK/8fdK5V2QvdumTJtX98CPZgVa4wYua8=;
        b=XO/yX7LEgs5Py5IcR0pKSxv0kqAvd7JX+EvT7RoHkRLj6XBdBgmc5kawEmQSEaOfCF
         befBBKyBZq+WQzNW+FffURQ7iannWXQeGXIpMnm2Hzrb0KAxm4qATsVouCrf8frCZRJq
         zJFo/9nCu8DmSzQW9l2UhDNx4m7+OQwYDWTXzt68joRfSKkOCyFG7v38va8fvVkDtCpe
         kUvye/5As7q+ij7ejRh5Wmz7WJ3EapCZ9iZOpGXBrkmaueHRg+beKqNU+1g3Hxef+haG
         Z/VemRSCEry5m2XrLM/UaS8LB0wsGl3bzSwE/TNObzcd7CM1464Tm7FWyYCP8aZTPfAg
         FmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zO1msM12y6bK/8fdK5V2QvdumTJtX98CPZgVa4wYua8=;
        b=cV17oFUtdsJjjFeNGG9pUVCNvc+qD/7vVLkkT2hqViZmWcQXyBqsofi1V+GBzG1cTL
         k5SfGGd2V20DUPiMvydOLra6D2gUSv9Iq2UBRDMxEOqJRP0JQzy95awU8A+902qGDUbm
         R5+rVE5/QMZ/skvwk6zYtitKcCYWAtd8xQEo+JuvFuozgTiPozezQ1yFcgp1jnvHxRhP
         zDqnHHF2nXmdXLQUJf6sxtDY5vgXNHwGLwHwl6xpAXy/8WFKhoNbN7QmFz+1rkLXvLU5
         2toB1xxlcAE1Z7iHC5CbKsXFwNrmXLFG+2WupO1TnymDCx6zkhXVMjCSp+AIF6wB0e2D
         PgZA==
X-Gm-Message-State: APjAAAWVnR5aomES9KUOh80q5n3WrjKZtGzYANYgltIx91SPFdfI1WoC
        ooGoF5VjxJ2ZT8Bfo8hXmFXXwB50a3ifng==
X-Google-Smtp-Source: APXvYqw6HBNLBRT4qap2VlmNpFP0hpowdCfqD8xcG3thhHrNf1RI2l30UMgogsfSlYWSB6xKCbTu0g==
X-Received: by 2002:a62:b406:: with SMTP id h6mr11911803pfn.260.1567791644954;
        Fri, 06 Sep 2019 10:40:44 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:49a:5f6f:e06:3c33])
        by smtp.gmail.com with ESMTPSA id e189sm6807500pgc.15.2019.09.06.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 10:40:44 -0700 (PDT)
Date:   Fri, 6 Sep 2019 11:40:41 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Florian Weimer <fweimer@redhat.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
Message-ID: <20190906174041.GH7627@cisco>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <20190906170739.kk3opr2phidb7ilb@yavin.dot.cyphar.com>
 <20190906172050.v44f43psd6qc6awi@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906172050.v44f43psd6qc6awi@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 06, 2019 at 07:20:51PM +0200, Christian Brauner wrote:
> On Sat, Sep 07, 2019 at 03:07:39AM +1000, Aleksa Sarai wrote:
> > On 2019-09-06, Mickaël Salaün <mickael.salaun@ssi.gouv.fr> wrote:
> > > 
> > > On 06/09/2019 17:56, Florian Weimer wrote:
> > > > Let's assume I want to add support for this to the glibc dynamic loader,
> > > > while still being able to run on older kernels.
> > > >
> > > > Is it safe to try the open call first, with O_MAYEXEC, and if that fails
> > > > with EINVAL, try again without O_MAYEXEC?
> > > 
> > > The kernel ignore unknown open(2) flags, so yes, it is safe even for
> > > older kernel to use O_MAYEXEC.
> > 
> > Depends on your definition of "safe" -- a security feature that you will
> > silently not enable on older kernels doesn't sound super safe to me.
> > Unfortunately this is a limitation of open(2) that we cannot change --
> > which is why the openat2(2) proposal I've been posting gives -EINVAL for
> > unknown O_* flags.
> > 
> > There is a way to probe for support (though unpleasant), by creating a
> > test O_MAYEXEC fd and then checking if the flag is present in
> > /proc/self/fdinfo/$n.
> 
> Which Florian said they can't do for various reasons.
> 
> It is a major painpoint if there's no easy way for userspace to probe
> for support. Especially if it's security related which usually means
> that you want to know whether this feature works or not.

What about just trying to violate the policy via fexecve() instead of
looking around in /proc? Still ugly, though.

Tycho
