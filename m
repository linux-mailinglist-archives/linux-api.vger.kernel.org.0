Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F9650BC
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2019 06:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfGKELx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jul 2019 00:11:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43384 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKELw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jul 2019 00:11:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so2288439plb.10;
        Wed, 10 Jul 2019 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSqx5lRhnvQ+7sTCSs3xCfsXxcwdrD2eEqRPLZvVrbA=;
        b=HQipN+bsvIBMHH7pXW047PoLn1gb24JU6O6094dySrF2kg2I9dihkWzrRRvEW5lmbx
         1WmRCHYsgMmVisomKYe2R9zHJVAGjer/+fC5cNecSCiC9ZOFF88hNsN8Bgc+8fFyZmBk
         pUnaMkAQL/N/+YyY12cO9ELzj3E7V5kOk18t/MYMKhvmpITlJVpl6YNlaTZ7p84fv+Q3
         dNMGD77wMSl+tMmXnHw0QccYZfTcT27l2F0ZmVBkiorsIagbeZx//DAzWP/AI9R9kgMV
         9RaUX0IuYTR0iL9W5nPOIGx73j+/VWjmf46iWkV3/kbhK7tEFEeWpcc+YkymY9Oc6szH
         ClEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSqx5lRhnvQ+7sTCSs3xCfsXxcwdrD2eEqRPLZvVrbA=;
        b=Ak27Wgk8I6t4u26yZB0FyFeYNGCAfl99mBjcrmMnJnxW+Wh1jDqHR/3aXBcOb+0+dX
         SOye7VvLTUpcw5XCAD7WWEyfXLuVKxxIe4ZMWtVV40MTpkUsqHnw4XNiu2ySgWOuGeGl
         ADOwsDGdFHqMKJPXYgzCvUjFgHgT3SIp+P9PtL47dzCb7WWI41cRmns/Fr14D35/GB2k
         sALdKcAfko4VoqmgrY/i6sWJRqOQJQWpOR9MQLbslBNauNZXiG7x3sFT5PojOsIH0VWe
         w9W1G9h5x0/Yy8ZvvYBF+KNdfkrt5qFy5UEg7WHg1rLORWtNxauJ2J14HGMNz58SMs1P
         OGnQ==
X-Gm-Message-State: APjAAAUaAiStmKGCw8J6P4GndXnoCJudtiJ/tRzAMHvt13q6VGyj6ptA
        bKrHEYx8JZBZ+CQNDXT3sH8=
X-Google-Smtp-Source: APXvYqz7t7+RwovcwFBuTIN5fXo1cdhnlVpoV9TKSdDMLz0WqLr7TyJkJsDJ2xPHxhsibEhdPdupFQ==
X-Received: by 2002:a17:902:42d:: with SMTP id 42mr2105475ple.228.1562818312183;
        Wed, 10 Jul 2019 21:11:52 -0700 (PDT)
Received: from linux-l9pv.suse ([202.47.205.198])
        by smtp.gmail.com with ESMTPSA id 12sm3586433pfi.60.2019.07.10.21.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 21:11:51 -0700 (PDT)
From:   joeyli <joeyli.kernel@gmail.com>
X-Google-Original-From: joeyli <jlee@suse.com>
Date:   Thu, 11 Jul 2019 12:11:45 +0800
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V34 10/29] hibernate: Disable when the kernel is locked
 down
Message-ID: <20190711041145.GA28145@linux-l9pv.suse>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-11-matthewgarrett@google.com>
 <20190622175208.GB30317@amd>
 <nycvar.YFH.7.76.1906241520500.27227@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1906241520500.27227@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi experts,

On Mon, Jun 24, 2019 at 03:21:23PM +0200, Jiri Kosina wrote:
> On Sat, 22 Jun 2019, Pavel Machek wrote:
> 
> > > There is currently no way to verify the resume image when returning
> > > from hibernate.  This might compromise the signed modules trust model,
> > > so until we can work with signed hibernate images we disable it when the
> > > kernel is locked down.
> > 
> > I keep getting these...
> > 
> > IIRC suse has patches to verify the images.
> 
> Yeah, Joey Lee is taking care of those. CCing.
>

The last time that I sent for hibernation encryption and authentication is
here:
    https://lkml.org/lkml/2019/1/3/281

It needs some big changes after review:
 - Simplify the design: remove keyring dependency and trampoline.
 - Encrypted whole snapshot image instead of only data pages.
 - Using TPM:
        - Direct use TPM API in hibernation instead of keyring
        - Localities (suggested by James Bottomley)

I am still finding enough time to implement those changes, especial TPM
parts.

Thanks
Joey Lee
