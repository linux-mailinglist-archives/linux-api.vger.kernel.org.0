Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E75669CE9
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfGOUii (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:38:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46589 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfGOUii (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:38:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so17651076ljg.13
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPYn0kigh/YyOOP3JdYIDFFrsPtkvgbvu1zMyQDVf3M=;
        b=b5eOePLKODPIzr8swDyYF4AgFldz7V2YABrA3742nAOHLzAo2/ozBZ0RJ8D5vddpk3
         sARlE/+axrtAh0KzWih8Ly0xxU5yIYpkYX1vuY4Ipmgobv3qAB/1jGKDo3KylvK7eHSd
         4sJcUaNpn2Mo0wTr/tITuzI5VkAFW1+L/TggkgJyTaDX57KahSyYfLsipraO3VrBagKt
         5af5hO2j+xukaou6B0ox1R1O0J8iM7BVCBnKA5cz6PdIvdxQIVHl7YCSpLQAA4Z6I3Z2
         jiNXl2hfASd4OE8vuNF//VDxwoQHOiejs0XJsKihnYXyCJwArlLVd3jylh7ferlCZnUf
         1LIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPYn0kigh/YyOOP3JdYIDFFrsPtkvgbvu1zMyQDVf3M=;
        b=RRc/QdsH/a2zP51dFjB+xu7peWt4N5GZbUNM8M9rFLEAijar77r7kN/1wNpNpqRsAr
         XSrxFwlD9lup0/f7WVZve+EIKy12T1NRBHKHv34gVVeYVDsrIiYjYtIoR0DtksVKTklU
         M51uUAE4irzxgVrXQR0TZ4JXW9fmg8iCFTWmcU88p+4DcqdrdoVpB+sX5ytk52hU5Nwa
         Wyln2+2fDy7Dx9q5gB6rx5RfeVkUyrWR90HwP1JgeUkvRuYJF6XZdPs4+5MDdXYiWL6B
         UgdIfNgnr8lYkX3WdaEYMbICZYDuro5AqnGYda60jiR/DL2hoqcJuzn1LZMXEwvo3zFr
         BR1g==
X-Gm-Message-State: APjAAAVBhccv1EF+1IxuJISBW2z5hzRs17vNuXHIryTnu98qosrtfwpB
        623GwyeXIktzKowDaCtZFXIaAzuwWZEalE8IkA==
X-Google-Smtp-Source: APXvYqy7ph4w7wyU2yk8+QNPGuKGKilYKae2+aEm11FJ7Oxrse5chHU3V+2dKv4MLJ5f+7kkorTp67H+wXIXoLMuFPs=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr15091488lja.85.1563223116334;
 Mon, 15 Jul 2019 13:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554732921.git.rgb@redhat.com> <9edad39c40671fb53f28d76862304cc2647029c6.1554732921.git.rgb@redhat.com>
 <20190529145742.GA8959@cisco> <CAHC9VhR4fudQanvZGYWMvCf7k2CU3q7e7n1Pi7hzC3v_zpVEdw@mail.gmail.com>
 <20190708175105.7zb6mikjw2wmnwln@madcap2.tricolour.ca>
In-Reply-To: <20190708175105.7zb6mikjw2wmnwln@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Jul 2019 16:38:25 -0400
Message-ID: <CAHC9VhRFeCFSCn=m6wgDK2tXBN1euc2+bw8o=CfNwptk8t=j7A@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 8, 2019 at 1:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-05-29 11:29, Paul Moore wrote:

...

> > The idea is that only container orchestrators should be able to
> > set/modify the audit container ID, and since setting the audit
> > container ID can have a significant effect on the records captured
> > (and their routing to multiple daemons when we get there) modifying
> > the audit container ID is akin to modifying the audit configuration
> > which is why it is gated by CAP_AUDIT_CONTROL.  The current thinking
> > is that you would only change the audit container ID from one
> > set/inherited value to another if you were nesting containers, in
> > which case the nested container orchestrator would need to be granted
> > CAP_AUDIT_CONTROL (which everyone to date seems to agree is a workable
> > compromise).  We did consider allowing for a chain of nested audit
> > container IDs, but the implications of doing so are significant
> > (implementation mess, runtime cost, etc.) so we are leaving that out
> > of this effort.
>
> We had previously discussed the idea of restricting
> orchestrators/engines from only being able to set the audit container
> identifier on their own descendants, but it was discarded.  I've added a
> check to ensure this is now enforced.

When we weren't allowing nested orchestrators it wasn't necessary, but
with the move to support nesting I believe this will be a requirement.
We might also need/want to restrict audit container ID changes if a
descendant is acting as a container orchestrator and managing one or
more audit container IDs; although I'm less certain of the need for
this.

> I've also added a check to ensure that a process can't set its own audit
> container identifier ...

What does this protect against, or what problem does this solve?
Considering how easy it is to fork/exec, it seems like this could be
trivially bypassed.

> ... and that if the identifier is already set, then the
> orchestrator/engine must be in a descendant user namespace from the
> orchestrator that set the previously inherited audit container
> identifier.

You lost me here ... although I don't like the idea of relying on X
namespace inheritance for a hard coded policy on setting the audit
container ID; we've worked hard to keep this independent of any
definition of a "container" and it would sadden me greatly if we had
to go back on that.

-- 
paul moore
www.paul-moore.com
