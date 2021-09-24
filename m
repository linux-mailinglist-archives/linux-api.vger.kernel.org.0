Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE66B417E06
	for <lists+linux-api@lfdr.de>; Sat, 25 Sep 2021 01:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbhIXXGR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 19:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344410AbhIXXGQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 24 Sep 2021 19:06:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B060661039;
        Fri, 24 Sep 2021 23:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632524683;
        bh=8Gn10cKU7CtsiOEauZx4GtwUoFgLAEPG53mOJzrLlVQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c5LlWTMhpUHgddMSAfJ9CrzhXWk/JnAM0D6mRTT/nPazU9tINDA0upOAoZ12580Je
         yDyeEBhLNDG47sJDpa7WHSp2oTjp9huYh8GajlG0YfWGug0h6M6T6RxRKJDhs4yKa1
         pDewtrQZGTrzQVNsChGQWOvzz/DDS+G6/zJ8N38LImu9Uw+iOLU5uZg9zzWi2zes8q
         GzhoDpcj00urKgSs2OoJguzzuE+UqqAqPXcz1dFRSar5QmXhBDSV8SKpz+NXAcbXYE
         MIbc0Qe+NL4cafFPf4ajhreoaYuFzBOPWQEs8OuXnvzytnRTkMHafjh7Tv/CKc5t4s
         MepQjuEVvT87g==
Message-ID: <b7390542-ea4a-de12-7567-734f6dbf488d@kernel.org>
Date:   Fri, 24 Sep 2021 16:04:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC] Expose request_module via syscall
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
References: <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
 <YUi95tFDWS7oceYP@bombadil.infradead.org>
 <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
 <20210922122523.72ypzg4pm2x6nkod@wittgenstein>
 <59e230b3-0e85-42ff-84a8-6b30ad0719d8@www.fastmail.com>
 <20210922155253.nj5dorsyv7loduws@wittgenstein>
 <0f209e1c-3d5c-46be-b5e7-323970112a8e@www.fastmail.com>
 <20210924131939.4jaou665fodiziml@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20210924131939.4jaou665fodiziml@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/24/21 06:19, Christian Brauner wrote:
> On Wed, Sep 22, 2021 at 01:06:49PM -0700, Andy Lutomirski wrote:

> I just meant that the programs in the container can see the modules
> available on the host. Simplest thing could be bind-mounting in the
> host's module folder with suitable protection (locked read-only mount).
> But yeah, it can likely be as simple as allowing it to ask for a module
> and not bother telling it about what is available.
> 

If the container gets to see host modules, interesting races when 
containers are migrated CRIU-style will result.
