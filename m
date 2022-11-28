Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C863A035
	for <lists+linux-api@lfdr.de>; Mon, 28 Nov 2022 04:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiK1DtG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 27 Nov 2022 22:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiK1DtG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 27 Nov 2022 22:49:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD811155
        for <linux-api@vger.kernel.org>; Sun, 27 Nov 2022 19:49:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d6so8955711pll.7
        for <linux-api@vger.kernel.org>; Sun, 27 Nov 2022 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89aaUv3n0AzXwCZrz3sUfTfmKWe0V9mGkRuHoglXv5U=;
        b=F4SbjpZUWp5gVN2m89hgsNNyAotwuAWKvbMF3CWNy7iGl9uEI1AXaxPYf0sFw8YtWK
         jOTLBbDCkwZK3iq7jd54vj0s47FJtl0zvGOhc40z82vKTv7zZkIo0JUYG8W5Jgg3YQ37
         XARGusor5xfZTrrh93vLVQcjXvb94idgLbZBcQS68wZcJc64e7gO3BWaKBKsgmm+XyZZ
         lW3gncOyuzJhWFXl/VZxDjYb50nr6c/frBa5EePd1NmQcLgMOurF4VylhhI0jk/PkK+0
         oj2W63ZPAySakpz3JDXI1jx0SdrNzQvCU7Bg/CE+pm/PWD3UkqPjqAj4zPMBr9asVq//
         hmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89aaUv3n0AzXwCZrz3sUfTfmKWe0V9mGkRuHoglXv5U=;
        b=wZ2jUyiEnO4ZPTTaeVu8EsvAupVlw2OAsX560p6Q/qkTbPDWst00fp/CCnrbfknkKB
         G4H8dsh7JdLyDmOhOxJ6q4fVakA4pEZpoeUt+um5KASq6LlJPvkLUIHfc1agBfFNWwOe
         1vF5XSQB/PWBG6OLP15cR9C3m6rJzRkaC6o0HVpNeRzMg3DrRX3QYz+iF4P0fZnctpkX
         Uxi97QyWbXPuqEhfdooPHP5TnP02wcFbnZZ9pfMTCtTerwHnOcPM/Xe/H9lofrp3znJB
         GUVmeNTQ9bBCm8r6RRIO2CGCCok7HP6LcN172skNj2/n1bM4AaNc/Ss/YgSY2G1t+LvS
         GsJw==
X-Gm-Message-State: ANoB5pl6dvGDPGQp3EnwVBOOL2gY9xya28QnWvpiZ2pwGyg4jUhk5tHA
        iqDz8u7rBr6Lbequ+Cm60jYXQQedWbU5QfasBQb/
X-Google-Smtp-Source: AA0mqf7RcLza/dRh0bacWs41PaOCR12ezszXApLSabQCoutYEWVUrDQ3Eh+QAcHd/5M8NFC4FiWv4UYCakNPPwooinE=
X-Received: by 2002:a17:903:28f:b0:189:8a36:1b70 with SMTP id
 j15-20020a170903028f00b001898a361b70mr3286900plr.12.1669607344298; Sun, 27
 Nov 2022 19:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20221123201552.7865-1-casey@schaufler-ca.com> <20221123201552.7865-2-casey@schaufler-ca.com>
 <Y38D1s3uQ6zNORei@kroah.com> <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
In-Reply-To: <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 27 Nov 2022 22:48:53 -0500
Message-ID: <CAHC9VhR9h1GF6VGovp1+UB-vt+QNofjmecPwLqE3OviKQHRMcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 25, 2022 at 11:19 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> On 24/11/2022 06:40, Greg KH wrote:
> > On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
> >> Create a struct lsm_id to contain identifying information
> >> about Linux Security Modules (LSMs). At inception this contains
> >> the name of the module and an identifier associated with the
> >> security module. Change the security_add_hooks() interface to
> >> use this structure. Change the individual modules to maintain
> >> their own struct lsm_id and pass it to security_add_hooks().
> >>
> >> The values are for LSM identifiers are defined in a new UAPI
> >> header file linux/lsm.h. Each existing LSM has been updated to
> >> include it's LSMID in the lsm_id.
> >>
> >> The LSM ID values are sequential, with the oldest module
> >> LSM_ID_CAPABILITY being the lowest value and the existing modules
> >> numbered in the order they were included in the main line kernel.
> >> This is an arbitrary convention for assigning the values, but
> >> none better presents itself. The value 0 is defined as being invalid.
> >> The values 1-99 are reserved for any special case uses which may
> >> arise in the future.
> >
> > What would be a "special case" that deserves a lower number?
>
> I don't see any meaningful use case for these reserved numbers either.
> If there are some, let's put them now, otherwise we should start with 1.
> Is it inspired by an existing UAPI?
> Reserving 0 as invalid is good though.

I haven't finished reviewing this latest patchset, but I wanted to
comment on this quickly while I had a moment in front of a keyboard
... I did explain my desire and reasoning for this in a previous
revision of this patchset and I still believe the
reserved-for-potential-future-use to be a valid reason so I'm going to
ask for this to remain.  Several of you may disagree, but unless you
can provide a reason why these reserved values would *seriously* break
these, or potential future syscalls, I'm going to be stubborn and
insist we retain a set of low-numbered reserved values.

--=20
paul-moore.com
