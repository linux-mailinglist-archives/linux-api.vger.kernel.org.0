Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E82D5A5D
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 06:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfJNE0h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 00:26:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:4316 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfJNE0h (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 Oct 2019 00:26:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 21:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="gz'50?scan'50,208,50";a="396365773"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Oct 2019 21:26:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iJrwG-0001Ez-Sv; Mon, 14 Oct 2019 12:26:32 +0800
Date:   Mon, 14 Oct 2019 12:26:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     kbuild-all@lists.01.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lokeshgidra@google.com,
        dancol@google.com, nnk@google.com, nosh@google.com,
        timmurray@google.com
Subject: Re: [PATCH 1/7] Add a new flags-accepting interface for anonymous
 inodes
Message-ID: <201910141205.p0k9FP1H%lkp@intel.com>
References: <20191012191602.45649-2-dancol@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="s3x2odwrgbgaoix5"
Content-Disposition: inline
In-Reply-To: <20191012191602.45649-2-dancol@google.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--s3x2odwrgbgaoix5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.4-rc3 next-20191011]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Colascione/Harden-userfaultfd/20191014-102741
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   fs/fs-writeback.c:918: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
>> fs/anon_inodes.c:139: warning: Function parameter or member 'anon_inode_flags' not described in 'anon_inode_getfd2'
   fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/libfs.c:501: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   kernel/dma/coherent.c:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
   drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
   mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:821: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'

vim +139 fs/anon_inodes.c

562787a5c32ccd Davide Libenzi    2009-09-22  119  
562787a5c32ccd Davide Libenzi    2009-09-22  120  /**
428e297f7ee416 Daniel Colascione 2019-10-12  121   * anon_inode_getfd2 - creates a new file instance by hooking it up to an
562787a5c32ccd Davide Libenzi    2009-09-22  122   *                     anonymous inode, and a dentry that describe the "class"
562787a5c32ccd Davide Libenzi    2009-09-22  123   *                     of the file
562787a5c32ccd Davide Libenzi    2009-09-22  124   *
562787a5c32ccd Davide Libenzi    2009-09-22  125   * @name:    [in]    name of the "class" of the new file
562787a5c32ccd Davide Libenzi    2009-09-22  126   * @fops:    [in]    file operations for the new file
562787a5c32ccd Davide Libenzi    2009-09-22  127   * @priv:    [in]    private data for the new file (will be file's private_data)
562787a5c32ccd Davide Libenzi    2009-09-22  128   * @flags:   [in]    flags
562787a5c32ccd Davide Libenzi    2009-09-22  129   *
562787a5c32ccd Davide Libenzi    2009-09-22  130   * Creates a new file by hooking it on a single inode. This is useful for files
562787a5c32ccd Davide Libenzi    2009-09-22  131   * that do not need to have a full-fledged inode in order to operate correctly.
562787a5c32ccd Davide Libenzi    2009-09-22  132   * All the files created with anon_inode_getfd() will share a single inode,
562787a5c32ccd Davide Libenzi    2009-09-22  133   * hence saving memory and avoiding code duplication for the file/inode/dentry
562787a5c32ccd Davide Libenzi    2009-09-22  134   * setup.  Returns new descriptor or an error code.
562787a5c32ccd Davide Libenzi    2009-09-22  135   */
428e297f7ee416 Daniel Colascione 2019-10-12  136  int anon_inode_getfd2(const char *name, const struct file_operations *fops,
428e297f7ee416 Daniel Colascione 2019-10-12  137  		      void *priv, int flags, int anon_inode_flags)
562787a5c32ccd Davide Libenzi    2009-09-22  138  {
562787a5c32ccd Davide Libenzi    2009-09-22 @139  	int error, fd;
562787a5c32ccd Davide Libenzi    2009-09-22  140  	struct file *file;
562787a5c32ccd Davide Libenzi    2009-09-22  141  
562787a5c32ccd Davide Libenzi    2009-09-22  142  	error = get_unused_fd_flags(flags);
562787a5c32ccd Davide Libenzi    2009-09-22  143  	if (error < 0)
562787a5c32ccd Davide Libenzi    2009-09-22  144  		return error;
562787a5c32ccd Davide Libenzi    2009-09-22  145  	fd = error;
562787a5c32ccd Davide Libenzi    2009-09-22  146  
428e297f7ee416 Daniel Colascione 2019-10-12  147  	file = anon_inode_getfile2(name, fops, priv, flags, anon_inode_flags);
562787a5c32ccd Davide Libenzi    2009-09-22  148  	if (IS_ERR(file)) {
562787a5c32ccd Davide Libenzi    2009-09-22  149  		error = PTR_ERR(file);
562787a5c32ccd Davide Libenzi    2009-09-22  150  		goto err_put_unused_fd;
562787a5c32ccd Davide Libenzi    2009-09-22  151  	}
5dc8bf8132d59c Davide Libenzi    2007-05-10  152  	fd_install(fd, file);
5dc8bf8132d59c Davide Libenzi    2007-05-10  153  
2030a42cecd4dd Al Viro           2008-02-23  154  	return fd;
5dc8bf8132d59c Davide Libenzi    2007-05-10  155  
5dc8bf8132d59c Davide Libenzi    2007-05-10  156  err_put_unused_fd:
5dc8bf8132d59c Davide Libenzi    2007-05-10  157  	put_unused_fd(fd);
5dc8bf8132d59c Davide Libenzi    2007-05-10  158  	return error;
5dc8bf8132d59c Davide Libenzi    2007-05-10  159  }
d6d281684913da Avi Kivity        2007-06-28  160  EXPORT_SYMBOL_GPL(anon_inode_getfd);
428e297f7ee416 Daniel Colascione 2019-10-12  161  EXPORT_SYMBOL_GPL(anon_inode_getfd2);
5dc8bf8132d59c Davide Libenzi    2007-05-10  162  

:::::: The code at line 139 was first introduced by commit
:::::: 562787a5c32ccdf182de27793a83a9f2ee86cd77 anonfd: split interface into file creation and install

:::::: TO: Davide Libenzi <davidel@xmailserver.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--s3x2odwrgbgaoix5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--s3x2odwrgbgaoix5--
