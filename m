Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D69193FEB
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 14:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCZNjU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 09:39:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39313 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNjU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 09:39:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so7832473wrt.6;
        Thu, 26 Mar 2020 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19Pztl4eD0UX0aRRYwPGEQuItPKM8kfOdpcItRtfgXE=;
        b=hRlHoyGy8kDiWVnPBKxURkaL2L6SV+ZOF7aFTlt6HAMDc4lpmQBa+Vb3s9p+CaVDJJ
         mTmkh/i+ZJKTMKxLxqQqUxLPxQ3YOtOt12C4E3nYIuDq8dxDcwkLYVP/y4QzNkQdGQ7V
         birRYr/08BDowOUnKTfBlrfZISo2lHnGVCwifT2fw+ATX2AlFEGqaeA9+VarjYIhgmG4
         3d8Z7dzk5N6hl+bHXJ2tkfmUJFccEIClwFGv8JllbAC1ndAtuiTdGJsK4fpM6T1/JMBC
         kf1xyJ2Ujr/A7g3R4xzHdF7CoY8skKzdux23/pymFUWrPb5gSLjtOBsW0addwPRWhEnh
         721w==
X-Gm-Message-State: ANhLgQ0PLxRlofV487m4oD+F0sZa5gTTgwck316e/ObuZXydLBurdyL3
        XB2aMZOHiqR2yjxD/MDZBjQ=
X-Google-Smtp-Source: ADFU+vtk9zmWZvzCHwkqppRQIVeYZ6TTx2b4k3bygVqfm3s1Ky3k2UREkOWABI0nEj77sewyC1P8pw==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr9083191wrx.382.1585229958157;
        Thu, 26 Mar 2020 06:39:18 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id 195sm3660380wmb.8.2020.03.26.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:39:17 -0700 (PDT)
Date:   Thu, 26 Mar 2020 14:39:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200326133915.GQ27965@dhcp22.suse.cz>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
 <20200326065829.GC27965@dhcp22.suse.cz>
 <20200326133041.a3zit3gzdqmphane@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326133041.a3zit3gzdqmphane@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 26-03-20 14:30:41, Christian Brauner wrote:
> On Thu, Mar 26, 2020 at 07:58:29AM +0100, Michal Hocko wrote:
> > On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
> > > Vlastimil Babka <vbabka@suse.cz> writes:
> > [...]
> > > > +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> > > > +		return 0;
> > > 
> > > Is there any way we can use a slash separated path.  I know
> > > in practice there are not any sysctl names that don't have
> > > a '.' in them but why should we artifically limit ourselves?
> > 
> > Because this is the normal userspace interface? Why should it be any
> > different from calling sysctl?
> > [...]
> 
> Imho, we should use ".". Kernel developers aren't the ones setting
> these options, admins are and if I think back to the times doing that as
> a job at uni I'd be very confused if I learned that I get to set sysctl
> options through the kernel command but need to use yet another format
> than what I usually do to set those from the shell. Consistency is most
> of the times to be preferred imho.

Absolutely agreed! Even if sysctl can consume / instead of ., which was a
news to me btw, the majority of the usage is with `.'
-- 
Michal Hocko
SUSE Labs
