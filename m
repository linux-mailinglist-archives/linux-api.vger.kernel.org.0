Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D9124FB
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 01:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfEBXT4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 May 2019 19:19:56 -0400
Received: from namei.org ([65.99.196.166]:37112 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfEBXT4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 2 May 2019 19:19:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x42NJnjw008283;
        Thu, 2 May 2019 23:19:49 GMT
Date:   Fri, 3 May 2019 09:19:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
In-Reply-To: <CACdnJuusGU2DMXaPAjH3+QOcSj-9q6njbxxG-9s2PweDKognvw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905030901180.7491@namei.org>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com> <alpine.LRH.2.21.1905030653480.32502@namei.org>
 <CACdnJuusGU2DMXaPAjH3+QOcSj-9q6njbxxG-9s2PweDKognvw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 2 May 2019, Matthew Garrett wrote:

> On Thu, May 2, 2019 at 2:07 PM James Morris <jmorris@namei.org> wrote:
> > One possible direction is to (as previously mentioned) assign IDs to each
> > callsite and be able to check this ID against a simple policy array
> > (allow/deny).  The default policy choices could be reduced to 'all' or
> > 'none' during kconfig, and allow a custom policy to be loaded later if
> > desired.
> 
> Ok. My primary concern around this is that it's very difficult to use
> correctly in anything other than the "all" or "none" modes. If a new
> kernel feature is added with integrated lockdown support, if an admin
> is simply setting the flags of things they wish to block then this
> will be left enabled - and may violate the admin's expectations around
> integrity. On the other hand, if an admin is simply setting the flags
> of things they wish to permit, then adding lockdown support to an
> existing kernel feature may result in that feature suddenly being
> disabled, which may also violate the admin's expectations around the
> flags providing a stable set of behaviour.

Understood. Most uses will likely be either a distro or an embedded 
system, who I'm assuming would provide a useful policy by default, and 
perhaps a high-level abstraction for modification.

> Given that, would you prefer such a policy expression to look like?

Perhaps a write-once policy, injected from userspace during early boot?

The policy could be simply a list of:

lockdown_feature true|false


> 
> > Within the policy check hook, we could add a new LSM hook, which would
> > allow an LSM to restrictively override the lockdown policy with its own
> 
> Ok, that makes sense. If we take this approach, does there need to be
> a separate policy mechanism at all? Users who want fine-grained
> control would be able to set the behaviour to "None" and then use
> their choice of LSM to express more fine-grained control.

Right, and there could be a stackable LSM which just does fine-grained 
policy (per above).


> 
> > This doesn't really address the completeness / maintenance issue (i.e. "do
> > we have everything covered and how do we ensure this on an ongoing
> > basis?", and "what will this new lockdown feature break?"), although it
> > should make it easier to add new lockdown callsites as they don't have to
> > be enabled by the user.
> 
> I can start on this.

Cool!

-- 
James Morris
<jmorris@namei.org>

