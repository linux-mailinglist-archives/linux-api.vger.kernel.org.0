Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27739524B
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfHTASL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:18:11 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:48926 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfHTASL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:11 -0400
Received: by mail-vk1-f202.google.com with SMTP id l3so2372782vkb.15
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VwF/91o4aMHrQL5QM73+22fSApAs/2NiXgYkaBxXzFM=;
        b=CUH1JVMihclalX5q2seurV8HS9Qtk8nNORqI67CyNzpt8f4YKj9PsBh2yhEiLjpN0N
         Fknxxgr4PJdGVml+Jh2OhZg5E3JvdD0eGWvF5Fmj48bmwNl5sWVh0boqVtCTRu0mQHas
         1xR/eyrBcny62z5z0RXhFDmY63lItRvyMCbNrGAku/YYgZEVoLwuK/uqG8c8z1Py5OSr
         A6r1/J/F5nwciw7FJDr6x0eGnjeLDqYrBnU6tU/LRSjombP6Ii7IjYs4x7MFqzCatoKk
         c5ORjqJyd7wx6vbPsu0EDtwg03Dm+tZqvDQMHo7P8iZ7nhjRLYSJI6ZiO9T9s7fsnTfy
         eFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VwF/91o4aMHrQL5QM73+22fSApAs/2NiXgYkaBxXzFM=;
        b=OLvL5Wb+b3d2caaRd3xsot8CDYhoi7AFA4FxppT2QhQe1e0dU32DBEasIxqBoPLYzB
         NZG3VzpVuGohhc5nHeB0sWa4oC+dXmQbgi9fhfg8R5P++WwmIbXqEjYFb3Xo/i0davyg
         mFhjHdreMbCFjYa81iOphT3I6qtTFsdG1rHBCmSpiCtWLl1MKWmAVip4lHRfKYtMO/16
         n/6JgidCt7U4AYYelKCjMVki43hZZ9toKvbHFX/TfO19p/90zj3bo/vWVh7e+C1IOllD
         UYwW+OS2G0RnCLbHvyMu/XfkdlCDwNy86cKduytnkqz9oOXV1snlEAANdbhaLzZq37Fx
         fLNQ==
X-Gm-Message-State: APjAAAXRT0nL7PzuXo4CrAKGdfdX22LW0EUXNimtQ1MzokWrW0Tl6x1B
        VKFhxWUXTh5sukrxYSTbFAXiS8Syn6gxJW1qYZMZ/Q==
X-Google-Smtp-Source: APXvYqz41WMqs6ZJ50zP00x9Ki+LU6ocf63OApf5Deq/yukX6RTwToHjUAj4ZEXRYb662kA7qgoSvA9acMVNeIZGiXQafw==
X-Received: by 2002:ac5:c801:: with SMTP id y1mr9262710vkl.41.1566260290111;
 Mon, 19 Aug 2019 17:18:10 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:36 -0700
Message-Id: <20190820001805.241928-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 00/29] Add kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

After chatting with James in person, I'm resending the full set with the
fixes merged in in order to avoid any bisect issues. There should be no
functional changes other than avoiding build failures with some configs,
and fixing the oops in tracefs.


