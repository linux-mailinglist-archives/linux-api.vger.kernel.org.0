Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E71685B7
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgBUR5E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 12:57:04 -0500
Received: from namei.org ([65.99.196.166]:47418 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUR5E (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 Feb 2020 12:57:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01LHujRq017470;
        Fri, 21 Feb 2020 17:56:45 GMT
Date:   Sat, 22 Feb 2020 04:56:45 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Daniel Colascione <dancol@google.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Tim Murray <timmurray@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
In-Reply-To: <CAKOZueuh2MR4UKi60-GVgPkXjncHx8J=mTTjRquB82CfS7DxBA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2002220456180.17337@namei.org>
References: <20200211225547.235083-1-dancol@google.com> <9ae20f6e-c5c0-4fd7-5b61-77218d19480b@schaufler-ca.com> <CAKOZueuh2MR4UKi60-GVgPkXjncHx8J=mTTjRquB82CfS7DxBA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 11 Feb 2020, Daniel Colascione wrote:

> > This must be posted to the linux Security Module list
> > <linux-security-module@vger.kernel.org>
> 
> Added. I thought selinux@ was sufficient.
> 

Please cc: me on these patches.

-- 
James Morris
<jmorris@namei.org>

