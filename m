Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2515F947
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 23:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBNWN6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 17:13:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:13171 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgBNWN6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 14 Feb 2020 17:13:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="gz'50?scan'50,208,50";a="257665148"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Feb 2020 14:13:52 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j2jDc-000CEm-44; Sat, 15 Feb 2020 06:13:52 +0800
Date:   Sat, 15 Feb 2020 06:13:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     kbuild-all@lists.01.org, dancol@google.com, timmurray@google.com,
        nosh@google.com, nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Add a concept of a "secure" anonymous file
Message-ID: <202002150657.5YrE7Byp%lkp@intel.com>
References: <20200211225547.235083-3-dancol@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20200211225547.235083-3-dancol@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on security/next-testing linux/master linus/master v5.6-rc1 next-20200214]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Colascione/Harden-userfaultfd/20200215-034039
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-4) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/anon_inodes.c: In function 'anon_inode_make_secure_inode':
>> fs/anon_inodes.c:67:10: error: implicit declaration of function 'security_inode_init_security_anon'; did you mean 'security_inode_init_security'? [-Werror=implicit-function-declaration]
     error = security_inode_init_security_anon(inode, name, fops);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             security_inode_init_security
   cc1: some warnings being treated as errors

vim +67 fs/anon_inodes.c

    57	
    58	struct inode *anon_inode_make_secure_inode(const char *name,
    59						   const struct file_operations *fops)
    60	{
    61		struct inode *inode;
    62		int error;
    63		inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
    64		if (IS_ERR(inode))
    65			return ERR_PTR(PTR_ERR(inode));
    66		inode->i_flags &= ~S_PRIVATE;
  > 67		error =	security_inode_init_security_anon(inode, name, fops);
    68		if (error) {
    69			iput(inode);
    70			return ERR_PTR(error);
    71		}
    72		return inode;
    73	}
    74	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aAAA

--tKW2IUtsqtDRztdT--
