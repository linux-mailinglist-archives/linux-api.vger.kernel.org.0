Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF414123D9
	for <lists+linux-api@lfdr.de>; Thu,  2 May 2019 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBVHV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 May 2019 17:07:21 -0400
Received: from namei.org ([65.99.196.166]:37082 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBVHV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 2 May 2019 17:07:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x42L7F4G000848;
        Thu, 2 May 2019 21:07:15 GMT
Date:   Fri, 3 May 2019 07:07:15 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
In-Reply-To: <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905030653480.32502@namei.org>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 29 Apr 2019, Matthew Garrett wrote:

> Hi James,
> 
> What's the best way forward with this? I'm still not entirely clear on
> how it can be implemented purely as an LSM, but if you have ideas on
> what sort of implementation you'd prefer I'm happy to work on that.

It can't be implemented purely as an LSM.

The concerns I have are:

  o Mixing of mechanism and policy (they are hardcoded together)
  o Too-coarse policy (all or nothing, which will lead many to choose   
    nothing)
  o Lack of integration with LSM
  o Completeness
  o Maintenance (including adding new lockdowns without breaking existing 
    userspace)
  
One possible direction is to (as previously mentioned) assign IDs to each 
callsite and be able to check this ID against a simple policy array 
(allow/deny).  The default policy choices could be reduced to 'all' or 
'none' during kconfig, and allow a custom policy to be loaded later if 
desired.

Within the policy check hook, we could add a new LSM hook, which would 
allow an LSM to restrictively override the lockdown policy with its own 
(so e.g. SELinux could utilize the context of the current process to 
determine if a lockdown feature should be enforced).

This doesn't really address the completeness / maintenance issue (i.e. "do 
we have everything covered and how do we ensure this on an ongoing 
basis?", and "what will this new lockdown feature break?"), although it 
should make it easier to add new lockdown callsites as they don't have to 
be enabled by the user.

Thoughts?

-- 
James Morris
<jmorris@namei.org>

