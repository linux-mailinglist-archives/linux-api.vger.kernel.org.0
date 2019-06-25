Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4D5233D
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfFYGE1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Jun 2019 02:04:27 -0400
Received: from namei.org ([65.99.196.166]:47546 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfFYGE1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 25 Jun 2019 02:04:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5P64Fvp031584;
        Tue, 25 Jun 2019 06:04:15 GMT
Date:   Tue, 25 Jun 2019 16:04:15 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@amacapital.net>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH V34 00/29] Lockdown as an LSM
In-Reply-To: <CACdnJut2erF9ZKeJQ+uvWZeEnHh=stmEioi_P36DF9mN5i2RGQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1906251601430.26271@namei.org>
References: <20190622000358.19895-1-matthewgarrett@google.com> <alpine.LRH.2.21.1906250853290.7826@namei.org> <CACdnJut2erF9ZKeJQ+uvWZeEnHh=stmEioi_P36DF9mN5i2RGQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 24 Jun 2019, Matthew Garrett wrote:

> > We are still not resolved on granularity. Stephen has said he's not sure
> > if a useful policy can be constructed with just confidentiality and
> > integrity settings. I'd be interested to know JJ and Casey's thoughts on
> > lockdown policy flexibility wrt their respective LSMs.
> 
> This implementation provides arbitrary granularity at the LSM level,
> though the lockdown LSM itself only provides two levels. Other LSMs
> can choose an appropriate level of exposure.

Ahh, OK, I only looked at the patchset description and had not looked at 
V33 yet.

This is looking good.


-- 
James Morris
<jmorris@namei.org>

