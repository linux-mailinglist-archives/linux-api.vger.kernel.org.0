Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F93184C7F
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2020 17:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCMQ30 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Mar 2020 12:29:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44167 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgCMQ3Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Mar 2020 12:29:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id g19so12561800eds.11
        for <linux-api@vger.kernel.org>; Fri, 13 Mar 2020 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQ+pObvU67uvaK3l1r4Ceb5YYAtUXZc7zlplXO9TGzk=;
        b=wNEa9VbCq5ppXpJfo1/v31ZhKG8uPf7PzMenc8z6vmEiPRA9w/pPKyW5PupisZ+2wm
         /1jR1aTmSmwc3VGYzygElLlxIeYf8iDy+ZYBCCFSAzNIo4Qhqf2EVsQY2xdC+JJray49
         u01vKpsXb8UXTPq9xL8qVflCmkWMFcPy3ohoVOFO6yr5Wx5vOxDNototKpEKY+8oXZNU
         ZY3T4uEoba21JC3zCnFHzr6tNBDmVkym5KePwLGcs3xFJU7aw/cie5ZNNSC+vyHPPitf
         6TxueY9wS4q7IPVNWnMTG7h0eYTj8SBvSH5GSRB+1Qrpcnnc6Wf/I+hp69E09N7FxlEV
         0bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQ+pObvU67uvaK3l1r4Ceb5YYAtUXZc7zlplXO9TGzk=;
        b=uGQL53KKJStttZs0SnPxDWNBAovnfEvQYxaNOGWKFoJ00mM0UfzJs4JLw56zMAahnZ
         vHiH+XflNx474WnXqoBGIFguKPlsttv8Y8qqgKxNJQwqVw/S9HrLw0kCUagvulqLqR+t
         0YKPhdzgBPC1gukY8CgaTV4GKWlGX5O3O6OUeTXZHRNaPy8EkuoIOmqouu1yl4S12Q/a
         FkgI+HDfSScN5CpJdeLdzDELK2FsJEweFQUAE3PCIFfYr3Kb0l6tFl8FWhx0V9GE3Yue
         CviqGD0HZSpMD1TVwgD7kZlMs/WmQoZO/gZrlkVKRi8CJyB9Da5pe9GBwMM5xGRB+XaS
         S40A==
X-Gm-Message-State: ANhLgQ05rOZJGEpw4Pe4tAonptzxvcZD+nQZB0cEgV8OHxnFlguOp8jq
        pH73Vd97TdLuxl4Hr37DFNXmzV9rIzp1YSvn8+cs
X-Google-Smtp-Source: ADFU+vuL+b7H+tHmfIL9uEWtaqijyChHCYny1ByjHCCYsp9IHY7VBWU/eiFjWL7wPzp8K/OQLrQaC/SDlvMtNAtsA5M=
X-Received: by 2002:a17:907:105a:: with SMTP id oy26mr3891035ejb.308.1584116962089;
 Fri, 13 Mar 2020 09:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <20200204231454.oxa7pyvuxbj466fj@madcap2.tricolour.ca>
 <CAHC9VhQquokw+7UOU=G0SsD35UdgmfysVKCGCE87JVaoTkbisg@mail.gmail.com>
 <3142237.YMNxv0uec1@x2> <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
 <CAHC9VhS09b_fM19tn7pHZzxfyxcHnK+PJx80Z9Z1hn8-==4oLA@mail.gmail.com> <20200312193037.2tb5f53yeisfq4ta@madcap2.tricolour.ca>
In-Reply-To: <20200312193037.2tb5f53yeisfq4ta@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Mar 2020 12:29:10 -0400
Message-ID: <CAHC9VhQoVOzy_b9W6h+kmizKr1rPkC4cy5aYoKT2i0ZgsceNDg@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 12, 2020 at 3:30 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-02-13 16:44, Paul Moore wrote:
> > This is a bit of a thread-hijack, and for that I apologize, but
> > another thought crossed my mind while thinking about this issue
> > further ... Once we support multiple auditd instances, including the
> > necessary record routing and duplication/multiple-sends (the host
> > always sees *everything*), we will likely need to find a way to "trim"
> > the audit container ID (ACID) lists we send in the records.  The
> > auditd instance running on the host/initns will always see everything,
> > so it will want the full container ACID list; however an auditd
> > instance running inside a container really should only see the ACIDs
> > of any child containers.
>
> Agreed.  This should be easy to check and limit, preventing an auditd
> from seeing any contid that is a parent of its own contid.
>
> > For example, imagine a system where the host has containers 1 and 2,
> > each running an auditd instance.  Inside container 1 there are
> > containers A and B.  Inside container 2 there are containers Y and Z.
> > If an audit event is generated in container Z, I would expect the
> > host's auditd to see a ACID list of "1,Z" but container 1's auditd
> > should only see an ACID list of "Z".  The auditd running in container
> > 2 should not see the record at all (that will be relatively
> > straightforward).  Does that make sense?  Do we have the record
> > formats properly designed to handle this without too much problem (I'm
> > not entirely sure we do)?
>
> I completely agree and I believe we have record formats that are able to
> handle this already.

I'm not convinced we do.  What about the cases where we have a field
with a list of audit container IDs?  How do we handle that?

-- 
paul moore
www.paul-moore.com
