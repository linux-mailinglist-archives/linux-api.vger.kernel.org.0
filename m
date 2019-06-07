Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC38BDE
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2019 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfFGNm4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 7 Jun 2019 09:42:56 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38443 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfFGNm4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 7 Jun 2019 09:42:56 -0400
Received: by mail-wr1-f42.google.com with SMTP id d18so2236980wrs.5
        for <linux-api@vger.kernel.org>; Fri, 07 Jun 2019 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4AUXFpUXPjn/D6XXKI9xc56D2KD8UQ7KyhdoOpG1dt0=;
        b=W9EBJZopw3q7ocZxpOTjEG4lU8Hfv75RlOKFZ+oSZR8uzCxkfZWDEi+EG+OJZ9kgmU
         YEnwXp3EKuN8UwItqSqnE6nT1ShJ58q8PSngiL/wS0jbYQ2RsUiMXU2PzJfFHHkzel3l
         7PhBRCRFCG5ZzBoe1pjlth3O9WL8T3KzW9+M67s2kPy4GF8GZEK8QbWGAMinPAqr7PWD
         d+WwecuEHnKlH3CYDd3LnEYX4uBBi8JujK7fHJYhKSWSauFqKWu0rR6JbujUCbWPSSlm
         ERO6WEnf2b5lQhKZMMp5VHavKZoHnp2xWzuEbTJEFyMrktrgu4wIdfCzj1M3WBGO3+uh
         Htsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4AUXFpUXPjn/D6XXKI9xc56D2KD8UQ7KyhdoOpG1dt0=;
        b=NFHNkMLKF0jgcvGobLvSrSgH3NXXBo6l8rMEVwRPzXZERFtBKMpoq9NLvy9uyRJud3
         9WEeAR11GUs49a8UUCjuiYT1bDI9SwkI83AurtPxKrGZ+5KDFOZXDCIPJpbIwpSrgt4J
         /IXFUKdCZXnQa0bljuJakNHEk0A+3l501RgHdD7+6J9u1s5p++YZjQQ86PJ7QcRbWrjx
         QgzYQLsUMYive5UuhZHNaBNNP9HV/AfHTG7YtiXyAqnrPysoOMq4eXyfGZmXTrw0+vHL
         AdCBsVG6U9XOWlkg7OXATNc2BVJDG7Dl/mNPlfFsiL2ZdpHDTh0oVJl+bo5JwoEOJPQQ
         GvUw==
X-Gm-Message-State: APjAAAUGoMngYrTgmNZ390MzfYW++xvLP8cF4RERIe23SYVGkKrTGb6q
        XhIGpM7F/z7KBA/9Rdiosdk8WA==
X-Google-Smtp-Source: APXvYqwaTsH/eZFofHfstgoptsYOuYgOt60R13LqnJmCrPEK4t5VyPo4EaZlhlMp2GmZW/kwAglqWg==
X-Received: by 2002:adf:9023:: with SMTP id h32mr34117799wrh.95.1559914974247;
        Fri, 07 Jun 2019 06:42:54 -0700 (PDT)
Received: from brauner.io (p54AC595E.dip0.t-ipconnect.de. [84.172.89.94])
        by smtp.gmail.com with ESMTPSA id 32sm4118460wra.35.2019.06.07.06.42.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 06:42:53 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:42:53 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC]: Convention for naming syscall revisions
Message-ID: <20190607134252.kf3e6ifm7qpw2cas@brauner.io>
References: <20190606154224.7lln4zp6v3ey4icq@brauner.io>
 <20190606235435.GD23169@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606235435.GD23169@mit.edu>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 06, 2019 at 07:54:35PM -0400, Theodore Ts'o wrote:
> On Thu, Jun 06, 2019 at 05:42:25PM +0200, Christian Brauner wrote:
> > Hey everyone,
> > 
> > I hope this is not going to start a trash fire.
> > 
> > While working on a new clone version I tried to find out what the
> > current naming conventions for syscall revisions is. I was told and
> > seemed to be able to confirm through the syscall list that revisions of
> > syscalls are for the most part (for examples see [1]) named after the
> > number of arguments and not for the number of revisions. But some also
> > seem to escape that logic (e.g. clone2).
> 
> There are also examples which show that it's a revision number:
> 
>       preadv2, pwritev2, mlock2, sync_file_range2
> 
> immediately come to mind.  It's also important to note that in some

Exactly, that's what made it confusing in the first place.

> cases, we do something very different (look aht the stat and fstat
> variants), and that in some cases the number of parameters for a

Sure, there will always be cases where we will revise a syscall but it
makes sense to name it completely different than its predecessor.
(Very different behavior, bad original naming immediately come to mind
as reasons.)

But for the general case where we do stuff like:
dup()
dup2()
dup3()

we could probably just make a call and document something like:

"If a syscall is revised and a completely new name is not warranted by
its design the consensus is to append the revision number."

and then maybe also add a brief section about what we historically did
and maybe also briefly point out what some good indicators are that a
completely new name could be used.

> system call vary between architectures (because of system call
> argument passing limitations), and this gets papered over by glibc.
> 
> So we can define what the historical pattern, but there might be a big
> difference between what might make sense as an internal naming
> convention, and the names that we want to expose to userspace
> application programmers --- especially if the number of arguments at

Right, but I am specifically interested in naming conventions for the
kernel not for userspace. :)

Christian
