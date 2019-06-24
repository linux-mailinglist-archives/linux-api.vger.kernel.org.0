Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3923C51EE2
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFXXBy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 19:01:54 -0400
Received: from namei.org ([65.99.196.166]:47492 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFXXBy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 24 Jun 2019 19:01:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5ON1iYt008506;
        Mon, 24 Jun 2019 23:01:44 GMT
Date:   Tue, 25 Jun 2019 09:01:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@amacapital.net>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH V34 00/29] Lockdown as an LSM
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1906250853290.7826@namei.org>
References: <20190622000358.19895-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 21 Jun 2019, Matthew Garrett wrote:

> Minor updates over V33 - security_is_locked_down renamed to
> security_locked_down, return value of security_locked_down is returned
> in most cases, one unnecessary patch was dropped, couple of minor nits
> fixed.

Thanks for the respin.

We are still not resolved on granularity. Stephen has said he's not sure 
if a useful policy can be constructed with just confidentiality and 
integrity settings. I'd be interested to know JJ and Casey's thoughts on 
lockdown policy flexibility wrt their respective LSMs.

These are also "all or nothing" choices which may prevent deployment due 
to a user needing to allow (presumably controlled or mitigated) exceptions 
to the policy.



-- 
James Morris
<jmorris@namei.org>

